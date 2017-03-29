<?php

namespace Craft;

use Calendar\Library\ColorHelper;

/**
 * @property int    $id
 * @property string $name
 * @property string $handle
 * @property string $description
 * @property string $color
 */
class Calendar_CalendarModel extends BaseModel
{
    const COLOR_LIGHTEN_MULTIPLIER = 0.2;
    const COLOR_DARKEN_MULTIPLIER = -0.2;

    /**
     * @return Calendar_CalendarModel
     */
    public static function create()
    {
        $model = new Calendar_CalendarModel();
        $model->color = ColorHelper::randomColor();

        return $model;
    }

    /**
     * Returns the calendar $name property
     *
     * @return string
     */
    public function __toString()
    {
        return $this->name;
    }

    /**
     * @return string - hex
     */
    public function getLighterColor()
    {
        return ColorHelper::lightenDarkenColour($this->color, self::COLOR_LIGHTEN_MULTIPLIER);
    }

    /**
     * @return string
     */
    public function getDarkerColor()
    {
        return ColorHelper::lightenDarkenColour($this->color, self::COLOR_DARKEN_MULTIPLIER);
    }

    /**
     * @return string - "black" or "white"
     */
    public function getContrastColor()
    {
        return ColorHelper::getContrastYIQ($this->color);
    }

    /**
     * @return array
     */
    protected function defineAttributes()
    {
        return array(
            'id'          => AttributeType::Number,
            'name'        => AttributeType::String,
            'handle'      => AttributeType::String,
            'description' => AttributeType::String,
            'color'       => AttributeType::String,
        );
    }
}
