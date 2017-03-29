<?php

namespace Calendar\Library\Events;

use Craft\Calendar_CalendarModel;

class Calendar
{
    /** @var int */
    private $id;

    /** @var string */
    private $name;

    /** @var string */
    private $handle;

    /** @var string */
    private $color;

    /** @var string */
    private $lighterColor;

    /** @var string */
    private $darkerColor;

    /** @var string */
    private $contrastColor;

    /**
     * @param Calendar_CalendarModel $calendarModel
     *
     * @return Calendar
     */
    public static function createFromModel(Calendar_CalendarModel $calendarModel = null)
    {
        $calendar = new Calendar();
        if (is_null($calendarModel)) {
            return $calendar;
        }

        $calendar->id            = $calendarModel->id;
        $calendar->name          = $calendarModel->name;
        $calendar->handle        = $calendarModel->handle;
        $calendar->color         = $calendarModel->color;
        $calendar->lighterColor  = $calendarModel->getLighterColor();
        $calendar->darkerColor   = $calendarModel->getDarkerColor();
        $calendar->contrastColor = $calendarModel->getContrastColor();

        return $calendar;
    }

    /**
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @return string
     */
    public function getHandle()
    {
        return $this->handle;
    }

    /**
     * @return string
     */
    public function getColor()
    {
        return $this->color;
    }

    /**
     * @return string
     */
    public function getLighterColor()
    {
        return $this->lighterColor;
    }

    /**
     * @return string
     */
    public function getDarkerColor()
    {
        return $this->darkerColor;
    }

    /**
     * @return string
     */
    public function getContrastColor()
    {
        return $this->contrastColor;
    }
}
