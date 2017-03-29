<?php

namespace Craft;

use Calendar\Library\Attributes\CalendarAttributes;
use Calendar\Library\PermissionsHelper;

class Calendar_CalendarsService extends BaseApplicationComponent
{
    /** @var Calendar_CalendarModel[] */
    private $calendarCache;
    private $allCalendarsCached;

    private $allowedCalendarCache;

    /**
     * @return Calendar_CalendarModel[]
     */
    public function getAllCalendars()
    {
        if (is_null($this->calendarCache) || !$this->allCalendarsCached) {
            $calendarRecords          = Calendar_CalendarRecord::model()->ordered()->findAll();
            $this->calendarCache      = Calendar_CalendarModel::populateModels($calendarRecords, 'id');
            $this->allCalendarsCached = true;
        }

        return $this->calendarCache;
    }

    /**
     * @return Calendar_CalendarModel[]
     */
    public function getAllAllowedCalendars()
    {
        if (PermissionsHelper::isAdmin()) {
            return $this->getAllCalendars();
        }

        if (is_null($this->allowedCalendarCache)) {
            $allowedCalendarIds = PermissionsHelper::getNestedPermissionIds(PermissionsHelper::PERMISSION_EVENTS_FOR);

            $calendarRecords            = Calendar_CalendarRecord::model()->ordered()->findAllById($allowedCalendarIds);
            $this->allowedCalendarCache = Calendar_CalendarModel::populateModels($calendarRecords, 'id');
        }

        return $this->allowedCalendarCache;
    }

    /**
     * Returns an array of calendar titles indexed by calendar ID
     *
     * @return array
     */
    public function getAllCalendarTitles()
    {
        $titleArray = array();
        $calendars  = $this->getAllCalendars();

        foreach ($calendars as $calendar) {
            $titleArray[$calendar->id] = $calendar->name;
        }

        return $titleArray;
    }

    /**
     * @return string
     */
    public function getLatestModificationDate()
    {
        return craft()
            ->db
            ->createCommand()
            ->select('MAX(dateUpdated)')
            ->from('calendar_calendars')
            ->limit(1)
            ->queryScalar();
    }

    /**
     * @return String
     */
    public function getAllCalendarCount()
    {
        return craft()
            ->db
            ->createCommand()
            ->select('COUNT(id)')
            ->from('calendar_calendars')
            ->queryScalar();
    }

    /**
     * Returns an array of calendar titles indexed by calendar ID
     *
     * @return array
     */
    public function getAllAllowedCalendarTitles()
    {
        $titleArray = array();
        $calendars  = $this->getAllAllowedCalendars();

        foreach ($calendars as $calendar) {
            $titleArray[$calendar->id] = $calendar->name;
        }

        return $titleArray;
    }

    /**
     * @param int $calendarId
     *
     * @return Calendar_CalendarModel
     */
    public function getCalendarById($calendarId)
    {
        $calendars = $this->getAllCalendars();

        if (isset($calendars[$calendarId])) {
            return $calendars[$calendarId];
        }

        return null;
    }

    /**
     * @param string $calendarHandle
     *
     * @return Calendar_CalendarModel
     */
    public function getCalendarByHandle($calendarHandle)
    {
        $calendarRecord = Calendar_CalendarRecord::model()->findByAttributes(array('handle' => $calendarHandle));

        if ($calendarRecord) {
            return Calendar_CalendarModel::populateModel($calendarRecord);
        }

        return null;
    }

    /**
     * @param Calendar_CalendarModel $calendar
     *
     * @return bool
     * @throws \Exception
     */
    public function saveCalendar(Calendar_CalendarModel $calendar)
    {
        $isNewCalendar = !$calendar->id;
        if ($isNewCalendar) {
            $calendarRecord = new Calendar_CalendarRecord();
        } else {
            $calendarRecord = Calendar_CalendarRecord::model()->findById($calendar->id);

            if (!$calendarRecord) {
                throw new Exception(Craft::t('calendar_id_not_found', array('id' => $calendar->id)));
            }
        }

        $beforeSaveCalendar = $this->onBeforeSave($calendar, $isNewCalendar);

        $calendarRecord->name        = $calendar->name;
        $calendarRecord->handle      = $calendar->handle;
        $calendarRecord->description = $calendar->description;
        $calendarRecord->color       = $calendar->color;

        $calendarRecord->validate();
        $calendar->addErrors($calendarRecord->getErrors());

        if ($beforeSaveCalendar->performAction && !$calendar->hasErrors()) {
            $transaction = craft()->db->getCurrentTransaction() === null ? craft()->db->beginTransaction() : null;
            try {
                $calendarRecord->save(false);

                if (!$calendar->id) {
                    $calendar->id = $calendarRecord->id;
                }

                $this->calendarCache[$calendar->id] = $calendar;

                if ($transaction !== null) {
                    $transaction->commit();
                }

                $this->onAfterSave($calendar, $isNewCalendar);
            } catch (\Exception $exception) {
                if ($transaction !== null) {
                    $transaction->rollback();
                }

                throw $exception;
            }

            return true;
        }

        return false;
    }

    /**
     * @param int $calendarId
     *
     * @return bool
     * @throws \Exception
     */
    public function deleteCalendarById($calendarId)
    {
        $calendar = $this->getCalendarById($calendarId);

        if (!$calendar) {
            return false;
        }

        if (!$this->onBeforeDelete($calendar)->performAction) {
            return false;
        }

        $transaction = craft()->db->getCurrentTransaction() === null ? craft()->db->beginTransaction() : null;
        try {
            // Grab the event ids so we can clean the elements table.
            $eventIds = craft()->db
                ->createCommand()
                ->select('id')
                ->from('calendar_events')
                ->where(array('calendarId' => $calendarId))
                ->queryColumn();

            craft()->elements->deleteElementById($eventIds);

            $affectedRows = craft()->db
                ->createCommand()
                ->delete('calendar_calendars', array('id' => $calendarId));

            if ($transaction !== null) {
                $transaction->commit();
            }

            $this->onAfterDelete($calendar);

            return (bool)$affectedRows;
        } catch (\Exception $exception) {
            if ($transaction !== null) {
                $transaction->rollback();
            }

            throw $exception;
        }
    }

    /**
     * @param null|array $attributes
     *
     * @return Calendar_CalendarModel[]
     */
    public function getCalendars($attributes = null)
    {
        $calendarAttributes = new CalendarAttributes($attributes);

        $calendars = Calendar_CalendarRecord::model()->findAll($calendarAttributes->getCriteria());

        if (empty($calendars)) {
            return array();
        }

        $calendarModels = Calendar_CalendarModel::populateModels($calendars);

        return $calendarModels;
    }

    /**
     * Raises an event before calendar saving
     *
     * @param Calendar_CalendarModel $calendarModel
     * @param bool                   $isNewCalendar
     *
     * @return Event
     */
    private function onBeforeSave(Calendar_CalendarModel $calendarModel, $isNewCalendar)
    {
        $event = new Event($this, ['calendar' => $calendarModel, 'isNewCalendar' => $isNewCalendar]);
        $this->raiseEvent(CalendarPlugin::EVENT_BEFORE_SAVE, $event);

        return $event;
    }

    /**
     * Raises an event after calendar saving
     *
     * @param Calendar_CalendarModel $calendarModel
     * @param bool                   $isNewCalendar
     *
     * @return Event
     */
    private function onAfterSave(Calendar_CalendarModel $calendarModel, $isNewCalendar)
    {
        $event = new Event($this, ['calendar' => $calendarModel, 'isNewCalendar' => $isNewCalendar]);
        $this->raiseEvent(CalendarPlugin::EVENT_AFTER_SAVE, $event);

        return $event;
    }

    /**
     * Raises an event before calendar deletion
     *
     * @param Calendar_CalendarModel $calendarModel
     *
     * @return Event
     */
    private function onBeforeDelete(Calendar_CalendarModel $calendarModel)
    {
        $event = new Event($this, ['calendar' => $calendarModel]);
        $this->raiseEvent(CalendarPlugin::EVENT_BEFORE_DELETE, $event);

        return $event;
    }

    /**
     * Raises an event after calendar deletion
     *
     * @param Calendar_CalendarModel $calendarModel
     *
     * @return Event
     */
    private function onAfterDelete(Calendar_CalendarModel $calendarModel)
    {
        $event = new Event($this, ['calendar' => $calendarModel]);
        $this->raiseEvent(CalendarPlugin::EVENT_AFTER_DELETE, $event);

        return $event;
    }
}
