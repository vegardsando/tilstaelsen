<?php

namespace Craft;

use Calendar\Library\DatabaseHelper;
use Calendar\Library\DateHelper;
use Calendar\Library\DateTimeUTC;
use Calendar\Library\Events\Event as EventObject;
use Calendar\Library\PermissionsHelper;
use Calendar\Library\Carbon;

class Calendar_EventsApiController extends BaseController
{
    const EVENT_FIELD_NAME = "calendarEvent";

    public function init()
    {
        $hasPermission = PermissionsHelper::checkPermission(PermissionsHelper::PERMISSION_EVENTS_FOR, true);

        if (!$hasPermission) {
            craft()->getUser()->requirePermission('trigger-calendar-event-access-denied');
        }

        parent::init();
    }

    /**
     * Modifies an event
     *
     * @return string JSON
     * @throws HttpException
     */
    public function actionModifyDate()
    {
        $this->requireLogin();
        $this->requirePostRequest();
        $this->requireAjaxRequest();

        /**
         * @var Calendar_EventModel $event
         * @var \DateInterval       $interval
         * @var bool                $isAllDay
         */
        list($event, $interval, $isAllDay) = $this->validateAndReturnModificationData();

        $eventsService = $this->getEventsService();

        $wasAllDay    = $event->allDay;
        $oldStartDate = $event->getStartDateCarbon();
        $startDate    = $event->getStartDateUTC();
        $startDate->add($interval);

        $endDateDiff = $oldStartDate->diff($event->getEndDateCarbon());

        $endDate = clone $startDate;
        $endDate->add($endDateDiff);


        $postedStartDateString  = craft()->request->getPost('startDate');
        $postedStartDate        = new DateTimeUTC($postedStartDateString);
        $originalOccurrenceDate = $postedStartDate->sub($interval);

        $isOriginalEvent = $originalOccurrenceDate->format('Y-m-d') === $event->getStartDateCarbon()->toDateString();

        // We update the event start and end dates ONLY if this isn' a "repeats on select dates" event
        // Or if it is and we're currently modifying the original event
        if (!$event->repeatsOnSelectDates() || $isOriginalEvent) {
            $event->startDate = $startDate;
            $event->endDate   = $endDate;
            $event->allDay    = $isAllDay;

            if ($wasAllDay && !$isAllDay) {
                $event->endDate = clone $startDate;
                $event->endDate->add(new \DateInterval('PT2H'));
            } else if (!$wasAllDay && $isAllDay) {
                $event->startDate->setTime(0, 0, 0);
                $event->endDate = clone $event->startDate;
                $event->endDate->setTime(23, 59, 59);
            }
        } elseif ($event->repeatsOnSelectDates() && !$isOriginalEvent) {
            $event->startDate = $event->getStartDateUTC();
            $event->startDate->setTime($startDate->format('H'), $startDate->format('i'), $startDate->format('s'));
            $event->endDate = clone $event->startDate;
            $event->endDate->add($endDateDiff);
        }

        if ($event->repeats()) {
            if ($event->repeatsOnSelectDates()) {
                if (!$isOriginalEvent) {
                    /** @var Calendar_ExceptionRecord[] $exceptionRecords */
                    $selectDateRecords = Calendar_SelectDateRecord::model()->findAllByAttributes(
                        array(
                            'eventId' => $event->id,
                            'date'    => $originalOccurrenceDate->format('Y-m-d'),
                        )
                    );

                    foreach ($selectDateRecords as $selectDate) {
                        $date = new DateTimeUTC($postedStartDateString);
                        $date->setTime(0, 0, 0);

                        $selectDate->date = $date;
                        $selectDate->save(false);
                    }
                }
            } else {
                $currentStartDate = $event->getStartDateCarbon();

                $diffInDays   = DateHelper::carbonDiffInDays($oldStartDate, $currentStartDate);
                $diffInMonths = DateHelper::carbonDiffInMonths($oldStartDate, $currentStartDate);

                $daysInterval         = new \DateInterval('P' . abs($diffInDays) . 'D');
                $daysInterval->invert = $diffInDays < 0 ? 1 : 0;

                if ($diffInDays != 0) {
                    $untilDate = $event->getUntilUTC();
                    if ($untilDate) {
                        $untilDate->add($daysInterval);
                        $event->until = $untilDate;
                    }

                    $eventsService->bumpRecurrenceRule($event, $diffInDays, $diffInMonths);

                    /** @var Calendar_ExceptionRecord[] $exceptionRecords */
                    $exceptionRecords = Calendar_ExceptionRecord::model()->findAllByAttributes(
                        array(
                            'eventId' => $event->id,
                        )
                    );

                    foreach ($exceptionRecords as $exception) {
                        $model = Calendar_ExceptionModel::populateModel($exception);

                        $date = new DateTimeUTC();
                        $date->setTimestamp($model->date->getTimestamp());
                        $date->add($daysInterval);

                        $exception->date = $date;
                        $exception->save(false);
                    }
                }
            }
        }

        $eventsService->saveEvent($event);

        $this->returnJson('success');
    }

    /**
     * Modifies the duration of an event
     *
     * @return string - JSON
     * @throws Exception
     * @throws HttpException
     * @throws \Exception
     */
    public function actionModifyDuration()
    {
        $this->requireLogin();
        $this->requirePostRequest();
        $this->requireAjaxRequest();

        /**
         * @var Calendar_EventModel $event
         * @var \DateInterval       $interval
         */
        list($event, $interval) = $this->validateAndReturnModificationData();

        $endDate = $event->getEndDateUTC();
        $endDate->add($interval);

        $event->endDate = $endDate;

        $this->getEventsService()->saveEvent($event);

        $this->returnJson("success");
    }

    /**
     * Quick-creates an event based on title and calendarID alone
     *
     * @return string - JSON
     * @throws HttpException
     */
    public function actionCreate()
    {
        $this->requireLogin();
        $this->requirePostRequest();
        $this->requireAjaxRequest();

        $eventData = craft()->request->getRequiredPost('event');
        $startDate = craft()->request->getRequiredPost('startDate');
        $endDate   = craft()->request->getRequiredPost('endDate');
        $isAllDay  = craft()->request->getPost('allDay', false);

        if (!isset($eventData['title']) || empty($eventData['title'])) {
            $this->returnErrorJson(Craft::t('event_title_required'));
        }

        if (!isset($eventData['calendarId']) || empty($eventData['calendarId'])) {
            $this->returnErrorJson(Craft::t('event_calendar_not_specified'));
        }

        /** @var Calendar_CalendarModel $calendar */
        $calendar = craft()->calendar_calendars->getCalendarById($eventData['calendarId']);

        if (!$calendar) {
            $this->returnErrorJson(Craft::t('event_calendar_does_not_exist'));
        }

        PermissionsHelper::requirePermission(
            PermissionsHelper::prepareNestedPermission(
                PermissionsHelper::PERMISSION_EVENTS_FOR,
                $calendar->id
            )
        );

        $startDate = DateTimeUTC::createFromString($startDate);
        $endDate   = DateTimeUTC::createFromString($endDate);

        if (!$startDate) {
            $this->returnErrorJson(Craft::t('event_start_date_required'));
        }

        if (!$endDate) {
            $this->returnErrorJson(Craft::t('event_end_date_required'));
        }

        if ($isAllDay) {
            $startDate->setTime(0, 0, 0);
            $endDate->setTime(23, 59, 59);
        }

        $event                      = Calendar_EventModel::create();
        $event->getContent()->title = $eventData['title'];
        $event->slug                = DatabaseHelper::getSuitableSlug($eventData['title']);
        $event->enabled             = true;

        $event->calendarId = $calendar->id;
        $event->startDate  = $startDate;
        $event->endDate    = $endDate;
        $event->allDay     = $isAllDay;

        if (craft()->calendar_events->saveEvent($event, false)) {
            $eventObject = EventObject::createFromModel($event, $event->getStartDateCarbon());

            $this->returnJson(array("event" => $eventObject->toSimpleObject()));
        } else {
            $this->returnErrorJson(Craft::t('Could not save event'));
        }
    }

    /**
     * Deletes an event
     *
     * @return string - JSON
     * @throws HttpException
     */
    public function actionDelete()
    {
        $this->requireLogin();
        $this->requirePostRequest();
        $this->requireAjaxRequest();

        $eventId = craft()->request->getRequiredPost('eventId');

        if (craft()->elements->deleteElementById($eventId)) {
            $this->returnJson('success');
        } else {
            $this->returnErrorJson(Craft::t('could_not_delete_event'));
        }
    }

    /**
     * Adds an exception to a recurring event
     *
     * @return string - JSON
     * @throws HttpException
     */
    public function actionDeleteOccurrence()
    {
        $this->requireLogin();
        $this->requirePostRequest();
        $this->requireAjaxRequest();

        $eventId = craft()->request->getPost('eventId');
        $date    = craft()->request->getPost('date');

        /** @var Calendar_EventModel $event */
        $event = craft()->calendar_events->getEventById($eventId);

        if (!$event) {
            $this->returnErrorJson(Craft::t('event_not_found'));
        }

        $date = DateTimeUTC::createFromString($date);
        $date->setTime(0, 0, 0);

        if ($event->repeatsOnSelectDates()) {
            craft()->calendar_selectDates->removeDate($event, $date);
        } else {
            craft()->calendar_exceptions->saveException($event, $date);
        }


        $this->returnJson("success");
    }

    /**
     * @return array|(Calendar_EventModel|\DateInterval)[]
     */
    private function validateAndReturnModificationData()
    {
        $eventId      = (int)craft()->request->getPost('eventId');
        $isAllDay     = craft()->request->getPost('isAllDay') == "true";
        $deltaSeconds = craft()->request->getPost('deltaSeconds');

        /** @var Calendar_EventModel $event */
        $event = $this->getEventsService()->getEventById($eventId, null, false);

        if ($event) {
            $interval = DateHelper::getDateIntervalFromSeconds($deltaSeconds);

            return array($event, $interval, $isAllDay);
        }

        $this->returnErrorJson(sprintf("No event with ID [%d] found", $eventId));
    }

    /**
     * @return Calendar_EventsService
     */
    private function getEventsService()
    {
        /** @var Calendar_EventsService $calendarEventService */
        $calendarEventService = craft()->calendar_events;

        return $calendarEventService;
    }
}
