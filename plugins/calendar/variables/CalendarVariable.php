<?php

namespace Craft;

use Calendar\Library\Carbon;
use Calendar\Library\DataObjects\OccurrenceLoader;
use Calendar\Library\DateHelper;
use Calendar\Library\Events\Event as EventObject;
use Calendar\Library\Events\EventList;
use Calendar\Library\Events\EventMonth;
use Calendar\Library\Export\ExportCalendarToIcs;
use Calendar\Library\RecurrenceHelper;

class CalendarVariable
{
    /**
     * @return string
     */
    public function showDemoTemplateBanner()
    {
        return !$this->settings()->isDemoBannerDisabled();
    }

    /**
     * @param array|null $attributes
     *
     * @return EventList
     */
    public function events($attributes = null)
    {
        /** @var Calendar_EventsService $eventsService */
        $eventsService = craft()->calendar_events;

        return $eventsService->getEventCriteria($attributes);
    }

    /**
     * Get a single event
     *
     * @param int   $id
     * @param array $options - [occurrenceDate, occurrenceRangeStart, occurrenceRangeEnd, occurrenceLimit]
     *
     * @return EventObject
     */
    public function event($id, $options = array())
    {
        if ($id == "new") {
            return EventObject::createFromModel(new Calendar_EventModel());
        }

        $targetDate = null;
        if (isset($options['occurrenceDate'])) {
            $targetDate = new Carbon($options['occurrenceDate'], DateTime::UTC);
        }

        $occurrenceRangeStart = null;
        if (isset($options['occurrenceRangeStart'])) {
            $occurrenceRangeStart = new Carbon($options['occurrenceRangeStart'], DateTime::UTC);
        }

        $occurrenceRangeEnd = null;
        if (isset($options['occurrenceRangeEnd'])) {
            $occurrenceRangeEnd = new Carbon($options['occurrenceRangeEnd'], DateTime::UTC);
        }

        $occurrenceLimit = null;
        if (isset($options['occurrenceLimit'])) {
            $occurrenceLimit = (int)$options['occurrenceLimit'];
        }

        $loadOccurrences = true;
        if (isset($options['loadOccurrences'])) {
            $loadOccurrences = $options['loadOccurrences'];
        }

        $occurrenceLoader = new OccurrenceLoader(
            $occurrenceRangeStart,
            $occurrenceRangeEnd,
            $occurrenceLimit,
            $loadOccurrences
        );

        $localeId = null;
        if (isset($options['locale'])) {
            $localeId = $options['locale'];
        }

        /** @var Calendar_EventsService $eventsService */
        $eventsService = craft()->calendar_events;

        $eventModel = null;
        if (is_numeric($id)) {
            $eventModel = $eventsService->getEventById($id, $localeId);
        } elseif (is_string($id)) {
            $eventModel = $eventsService->getEventBySlug($id, $localeId);
        }

        if (!$eventModel) {
            return null;
        }

        $event = EventObject::createFromModel($eventModel, $targetDate, $occurrenceLoader);

        return $event;
    }

    /**
     * @param array $events
     */
    public function export($events)
    {
        if ($events instanceof Calendar_EventCriteriaModel) {
            $events = $events->find();
        }

        $exporter = new ExportCalendarToIcs($events);

        $exporter->export();
    }

    /**
     * @param array|null $attributes
     *
     * @return EventList
     */
    public function calendars($attributes = null)
    {
        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;

        return $calendarService->getCalendars($attributes);
    }

    /**
     * Returns a SHA-1 hash of the latest modification date and calendar count
     *
     * @return string
     */
    public function calendarsCacheKey()
    {
        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;

        return sha1($calendarService->getLatestModificationDate() . $calendarService->getAllCalendarCount());
    }

    /**
     * Returns a SHA-1 hash of the latest modification date and event count
     *
     * @return string
     */
    public function eventsCacheKey()
    {
        /** @var Calendar_EventsService $eventsService */
        $eventsService = craft()->calendar_events;

        return sha1($eventsService->getLatestModificationDate() . $eventsService->getAllEventCount());
    }

    /**
     * @param array|null $attributes
     *
     * @return Calendar_CalendarModel|null
     */
    public function calendar($attributes = null)
    {
        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;

        $calendarList  = $calendarService->getCalendars($attributes);
        $firstCalendar = reset($calendarList);

        return $firstCalendar;
    }

    /**
     * @return array
     */
    public function allowedCalendars()
    {
        /** @var Calendar_CalendarsService $calendarService */
        $calendarService = craft()->calendar_calendars;

        return $calendarService->getAllAllowedCalendars();
    }

    /**
     * @param array $attributes
     *
     * @return EventMonth
     */
    public function month(array $attributes = null)
    {
        /** @var Calendar_ViewDataService $viewDataService */
        $viewDataService = craft()->calendar_viewData;

        return $viewDataService->getMonth($attributes);
    }

    /**
     * @param array $attributes
     *
     * @return EventMonth
     */
    public function week(array $attributes = null)
    {
        /** @var Calendar_ViewDataService $viewDataService */
        $viewDataService = craft()->calendar_viewData;

        return $viewDataService->getWeek($attributes);
    }

    /**
     * @param array $attributes
     *
     * @return EventMonth
     */
    public function day(array $attributes = null)
    {
        /** @var Calendar_ViewDataService $viewDataService */
        $viewDataService = craft()->calendar_viewData;

        return $viewDataService->getDay($attributes);
    }

    /**
     * @param array $attributes
     *
     * @return EventMonth
     */
    public function hour(array $attributes = null)
    {
        /** @var Calendar_ViewDataService $viewDataService */
        $viewDataService = craft()->calendar_viewData;

        return $viewDataService->getHour($attributes);
    }

    /**
     * @return Calendar_SettingsService
     */
    public function settings()
    {
        return craft()->calendar_settings;
    }

    /**
     * @return array
     */
    public function frequencyOptions()
    {
        return RecurrenceHelper::getFrequencyOptions();
    }

    /**
     * @return array
     */
    public function repeatsByOptions()
    {
        return RecurrenceHelper::getRepeatsByOptions();
    }

    /**
     * @return array
     */
    public function weekDaysShort()
    {
        return DateHelper::getWeekDaysShort();
    }

    /**
     * @return array
     */
    public function monthDays()
    {
        return DateHelper::getMonthDays();
    }

    /**
     * @return array
     */
    public function monthNames()
    {
        return DateHelper::getMonthNames();
    }
}
