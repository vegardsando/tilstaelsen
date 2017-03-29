<?php

namespace Craft;

use Calendar\Library\Carbon;

class Calendar_ViewController extends BaseController
{
    const VIEW_MONTH = 'month';
    const VIEW_WEEK  = 'week';
    const VIEW_DAY   = 'day';

    public function actionMonthData()
    {
        $this->requireAjaxRequest();
        $this->requirePostRequest();

        $dateRangeStart = craft()->request->getPost('dateRangeStart');
        $dateRangeEnd   = craft()->request->getPost('dateRangeEnd');
        $calendars      = craft()->request->getPost('calendars', null);
        $nonEditable    = craft()->request->getPost('nonEditable');

        $criteria = array(
            'dateRangeStart' => $dateRangeStart,
            'dateRangeEnd'   => $dateRangeEnd,
        );

        $calendarIds = null;
        if ($calendars) {
            if ($calendars != "*") {
                $criteria['calendarId'] = explode(',', $calendars);
            }
        } elseif (!is_null($calendars)) {
            $criteria['calendarId'] = -1;
        }

        /** @var Calendar_EventsService $eventsService */
        $eventsService = craft()->calendar_events;

        if (craft()->isLocalized()) {
            $criteria['locale'] = craft()->language;
        }

        // Check settings if disabled events should be shown

        /** @var Calendar_SettingsService $settings */
        $settings = craft()->calendar_settings;
        if ($settings->showDisabledEvents()) {
            $criteria["status"] = null;
        }

        $eventList    = $eventsService->getEventList($criteria);
        $simpleEvents = $eventList->getEventsAsSimpleObject();

        if ($nonEditable) {
            foreach ($simpleEvents as $event) {
                $event->editable = false;
            }
        }

        $this->returnJson($simpleEvents);
    }

    /**
     * @param array $variables
     *
     * @throws HttpException
     */
    public function actionTargetTime(array $variables = array())
    {
        $view         = isset($variables['view']) ? $variables['view'] : self::VIEW_MONTH;
        $calendarView = $view;

        switch ($calendarView) {
            case 'week':
                $calendarView = 'agendaWeek';
                break;

            case 'day':
                $calendarView = 'agendaDay';
                break;
        }

        if (isset($variables['year'])) {
            $year  = $variables['year'];
            $month = $variables['month'];
            $day   = $variables['day'];

            $currentDay = Carbon::createFromDate($year, $month, $day, DateTime::UTC);
        } else {
            $currentDay = new Carbon(DateTime::UTC);
        }

        $calendarLocale   = craft()->locale->id;
        $localeModulePath = CRAFT_PLUGINS_PATH . 'calendar/resources/js/fullcalendar/lang/' . $calendarLocale . '.js';
        if (!IOHelper::fileExists($localeModulePath)) {
            $calendarLocale = 'en';
        }

        $calendarOptions = craft()->calendar_calendars->getAllAllowedCalendarTitles();

        $variables = array(
            'currentDay'      => $currentDay,
            'currentView'     => $view,
            'calendarView'    => $calendarView,
            'calendarLocale'  => $calendarLocale,
            'calendarOptions' => $calendarOptions,
        );

        $this->renderTemplate("calendar/view/calendar", $variables);
    }

    /**
     * @throws HttpException
     */
    public function actionMiniCal()
    {
        $targetDate = craft()->request->getPost('date');
        $calendars  = craft()->request->getPost('calendars');

        $this->renderTemplate(
            'calendar/_widgets/month/mini-cal',
            array(
                'targetDate' => $targetDate,
                'calendars'  => $calendars,
            )
        );
    }

    /**
     * @throws HttpException
     */
    public function actionDismissDemoAlert()
    {
        $this->requireAdmin();
        $this->requireAjaxRequest();

        $demoDismissed = craft()->calendar_settings->dismissDemoBanner();
        if ($demoDismissed) {
            $this->returnJson('success');
        }

        $this->returnErrorJson("Could not save plugin settings. Plugin not enabled.");
    }
}
