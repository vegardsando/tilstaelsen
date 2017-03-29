<?php

namespace Calendar\Library;

use Craft\Craft;

class RecurrenceHelper
{
    const DAILY        = 'DAILY';
    const WEEKLY       = 'WEEKLY';
    const MONTHLY      = 'MONTHLY';
    const YEARLY       = 'YEARLY';
    const SELECT_DATES = 'SELECT_DATES';

    /**
     * @var array
     */
    private static $frequencyOptions = array(
        self::DAILY        => 'event_frequency_day',
        self::WEEKLY       => 'event_frequency_week',
        self::MONTHLY      => 'event_frequency_month',
        self::YEARLY       => 'event_frequency_year',
        self::SELECT_DATES => 'event_frequency_select_dates',
    );

    /**
     * @var array
     */
    private static $repeatsByOptions = array(
        1  => 'event_repeats_by_first',
        2  => 'event_repeats_by_second',
        3  => 'event_repeats_by_third',
        4  => 'event_repeats_by_fourth',
        -1 => 'event_repeats_by_last',
    );


    /**
     * Returns frequency options indexed by RRule frequency string and translates the values
     * [DAILY => Days(s), WEEKLY => Week(s), MONTHLY => Month(s), YEARLY => Year(s)]
     *
     * @return array
     */
    public static function getFrequencyOptions()
    {
        $translatedOptions = array();
        foreach (self::$frequencyOptions as $key => $value) {
            $translatedOptions[$key] = Craft::t($value);
        }

        return $translatedOptions;
    }

    /**
     * Repeats By Week Day options
     * First, second, third, fourth or last (translated)
     *
     * @return array
     */
    public static function getRepeatsByOptions()
    {
        $translatedOptions = array();
        foreach (self::$repeatsByOptions as $key => $value) {
            $translatedOptions[$key] = Craft::t($value);
        }

        return $translatedOptions;
    }
}
