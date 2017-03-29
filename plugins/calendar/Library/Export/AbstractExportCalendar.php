<?php

namespace Calendar\Library\Export;

use Calendar\Library\Events\EventList;

abstract class AbstractExportCalendar implements ExportCalendarInterface
{

    /** @var EventList */
    private $events;

    /**
     * @param EventList $events
     */
    public final function __construct(EventList $events)
    {
        $this->events = $events;
    }

    /**
     * Collects the exportable string and outputs it
     * Sets headers to file download and content-type to text/calendar
     *
     * @return string
     */
    public final function export()
    {
        header('Content-type: text/calendar; charset=utf-8');
        header('Content-Disposition: attachment; filename=' . time() . '.ics');

        $exportString = $this->prepareStringForExport();

        echo $exportString;
        exit();
    }

    /**
     * Collect events and parse them, and build a string
     * That will be exported to a file
     *
     * @return string
     */
    protected abstract function prepareStringForExport();

    /**
     * @return EventList
     */
    protected final function getEvents()
    {
        return $this->events;
    }

    /**
     * @param string $string
     *
     * @return string
     */
    protected final function escapeString($string)
    {
        return preg_replace('/([\,;])/', '\\\$1', $string);
    }
}
