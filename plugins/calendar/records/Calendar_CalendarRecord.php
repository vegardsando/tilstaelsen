<?php

namespace Craft;

/**
 * @property int                    $id
 * @property string                 $name
 * @property string                 $handle
 * @property string                 $description
 * @property string                 $color
 * @property Calendar_EventRecord[] $events
 */
class Calendar_CalendarRecord extends BaseRecord
{
    /**
     * @return string
     */
    public function getTableName()
    {
        return 'calendar_calendars';
    }

    /**
     * @return array
     */
    public function defineRelations()
    {
        return array(
            'events' => array(
                self::HAS_MANY,
                'Calendar_EventRecord',
                'eventId',
            ),
        );
    }

    /**
     * @return array
     */
    public function defineIndexes()
    {
        return array(
            array('columns' => array('name'), 'unique' => true),
            array('columns' => array('handle'), 'unique' => true),
        );
    }

    /**
     * @return array
     */
    public function scopes()
    {
        return array(
            'ordered' => array('order' => 'name'),
        );
    }

    /**
     * @return array
     */
    protected function defineAttributes()
    {
        return array(
            'name'        => array(AttributeType::Name, 'required' => true),
            'handle'      => array(AttributeType::Handle, 'required' => true),
            'description' => AttributeType::String,
            'color'       => array(AttributeType::String, 'required' => true),
        );
    }
}
