<?php

namespace Craft;

use Calendar\Library\Carbon;
use Calendar\Library\DateHelper;
use Calendar\Library\DateTimeUTC;
use Calendar\Library\PermissionsHelper;
use Calendar\Library\RecurrenceHelper;
use RRule\RRule;

/**
 * @property int      $id
 * @property int      $elementId
 * @property int      $calendarId
 * @property int      $authorId
 * @property DateTime $startDate
 * @property DateTime $endDate
 * @property bool     $allDay
 * @property string   $rrule
 * @property string   $freq
 * @property int      $interval
 * @property int      $count
 * @property DateTime $until
 * @property string   $byMonth
 * @property string   $byYearDay
 * @property string   $byMonthDay
 * @property string   $byDay
 */
class Calendar_EventModel extends BaseElementModel
{
    const ELEMENT_TYPE = 'Calendar_Event';

    const UNTIL_TYPE_FOREVER = 'forever';
    const UNTIL_TYPE_UNTIL   = 'until';
    const UNTIL_TYPE_COUNT   = 'count';

    /** @var string */
    protected $elementType = self::ELEMENT_TYPE;

    /** @var Calendar_ExceptionModel[] */
    private $exceptions;

    /** @var array */
    private $selectDatesCache;

    /** @var int */
    private static $overlapThreshold;

    /**
     * @param string $locale
     *
     * @return Calendar_EventModel
     */
    public static function create($locale = null)
    {
        /** @var Calendar_SettingsService $settings */
        $settings = craft()->calendar_settings;

        $model           = new Calendar_EventModel();
        $model->allDay   = $settings->isAllDayDefault();
        $model->authorId = craft()->userSession->getId();
        $model->enabled  = true;
        if ($locale) {
            $model->locale = $locale;
        }

        return $model;
    }

    /**
     * Returns whether the current user can edit the element.
     *
     * @return bool
     */
    public function isEditable()
    {
        return PermissionsHelper::checkPermission(
            PermissionsHelper::prepareNestedPermission(
                PermissionsHelper::PERMISSION_EVENTS_FOR,
                $this->getCalendar()->id
            )
        );
    }

    /**
     * Returns the element's CP edit URL.
     *
     * @return string|false
     */
    public function getCpEditUrl()
    {
        $locale = (craft()->isLocalized() && $this->locale != craft()->language) ? '/' . $this->locale : '';

        return UrlHelper::getCpUrl('calendar/events/' . $this->id . $locale);
    }

    /**
     * Returns the field layout used by this element.
     *
     * @return FieldLayoutModel|null
     */
    public function getFieldLayout()
    {
        return craft()->fields->getLayoutByType(CalendarPlugin::FIELD_LAYOUT_TYPE);
    }

    /**
     * @return Calendar_CalendarModel
     */
    public function getCalendar()
    {
        if ($this->calendarId) {
            return craft()->calendar_calendars->getCalendarById($this->calendarId);
        }

        return null;
    }

    /**
     * @return UserModel|null
     */
    public function getAuthor()
    {
        if ($this->authorId) {
            return craft()->users->getUserById($this->authorId);
        }

        return null;
    }

    /**
     * @return Calendar_ExceptionModel[]
     */
    public function getExceptions()
    {
        if (is_null($this->exceptions)) {
            $this->exceptions = craft()->calendar_exceptions->getExceptionsForEvent($this);
        }

        return $this->exceptions;
    }

    /**
     * @return array
     */
    public function getExceptionDateStrings()
    {
        $exceptions = $this->getExceptions();

        $exceptionDates = array();
        foreach ($exceptions as $exception) {
            $date = new DateTimeUTC();
            $date->setTimestamp($exception->date->getTimestamp());

            $exceptionDates[] = $date->format('Y-m-d');
        }

        return $exceptionDates;
    }

    /**
     * @param \DateTime $rangeStart
     * @param \DateTime $rangeEnd
     *
     * @return Calendar_SelectDateModel[]
     */
    public function getSelectDates(\DateTime $rangeStart = null, \DateTime $rangeEnd = null)
    {
        if ($this->freq !== RecurrenceHelper::SELECT_DATES) {
            return array();
        }

        $cacheHash = md5(($rangeStart ? $rangeStart->getTimestamp() : 0) . ($rangeEnd ? $rangeEnd->getTimestamp() : 0));
        if (!isset($this->selectDatesCache[$cacheHash])) {
            $this->selectDatesCache[$cacheHash] = craft()
                ->calendar_selectDates
                ->getSelectDatesForEvent($this, $rangeStart, $rangeEnd);
        }

        return $this->selectDatesCache[$cacheHash];
    }

    /**
     * @param \DateTime $rangeStart
     * @param \DateTime $rangeEnd
     *
     * @return array|\Calendar\Library\DateTimeUTC[]
     */
    public function getSelectDatesAsDates(\DateTime $rangeStart = null, \DateTime $rangeEnd = null)
    {
        $selectDates = $this->getSelectDates($rangeStart, $rangeEnd);

        $selectDatesList = array();
        foreach ($selectDates as $selectDate) {
            $date = new DateTimeUTC();
            $date->setTimestamp($selectDate->date->getTimestamp());

            $selectDatesList[] = $date;
        }

        return $selectDatesList;
    }

    /**
     * @param string $format
     *
     * @return array
     */
    public function getSelectDatesAsString($format = 'Y-m-d')
    {
        $selectDates = $this->getSelectDates();

        $formattedDatesList = array();
        foreach ($selectDates as $selectDate) {
            $date = new DateTimeUTC();
            $date->setTimestamp($selectDate->date->getTimestamp());

            $formattedDatesList[] = $date->format($format);
        }

        return $formattedDatesList;
    }

    /**
     * @return bool
     */
    public function isMultiDay()
    {
        if (is_null(self::$overlapThreshold)) {
            self::$overlapThreshold = craft()->calendar_settings->getOverlapThreshold();
        }

        $startDate = $this->getStartDateCarbon();
        $endDate   = $this->getEndDateCarbon();

        if (!$startDate || !$endDate) {
            return false;
        }

        $diffInDays = DateHelper::carbonDiffInDays($startDate, $endDate);

        if ($diffInDays > 1) {
            return true;
        } elseif ($diffInDays === 1 && !DateHelper::isDateBeforeOverlap(
                $this->getEndDateCarbon(),
                self::$overlapThreshold
            )
        ) {
            return true;
        }

        return false;
    }

    /**
     * @return bool
     */
    public function repeats()
    {
        return !is_null($this->freq);
    }

    /**
     * @return bool
     */
    public function repeatsOnSelectDates()
    {
        return $this->repeats() && $this->freq === RecurrenceHelper::SELECT_DATES;
    }

    /**
     * @return string|null
     */
    public function getFrequency()
    {
        switch ($this->freq) {
            case RecurrenceHelper::DAILY:
            case RecurrenceHelper::WEEKLY:
            case RecurrenceHelper::MONTHLY:
            case RecurrenceHelper::YEARLY:
            case RecurrenceHelper::SELECT_DATES:
                return $this->freq;

            default:
                return null;
        }
    }

    /**
     * Returns an array of \DateTime objects for each recurrence
     *
     * @return array|\DateTime[]
     */
    public function getOccurrenceDates()
    {
        $occurrences = $this->getOccurrenceDatesBetween();

        return $occurrences;
    }

    /**
     * @param \DateTime|null $rangeStart
     * @param \DateTime|null $rangeEnd
     *
     * @return array|\DateTIme[]
     */
    public function getOccurrenceDatesBetween(\DateTime $rangeStart = null, \DateTime $rangeEnd = null)
    {
        $occurrences = array();

        if ($this->repeats()) {
            if ($this->repeatsOnSelectDates()) {
                $startDate = $this->getStartDateUTC();
                if ((!$rangeStart || $startDate >= $rangeStart) && (!$rangeEnd || $startDate <= $rangeEnd)) {
                    $occurrences[] = $startDate->setTime(0, 0, 0);
                }
                
                $occurrences = array_merge($occurrences, $this->getSelectDatesAsDates($rangeStart, $rangeEnd));
            } else {
                $rrule = $this->getRRuleObject();
                if (!is_null($rrule)) {
                    if ($this->isInfinite()) {
                        $rangeStart = $rangeStart ?: new Carbon("today", DateTime::UTC);
                        $rangeEnd = $rangeEnd ?: new Carbon("+6 months", DateTime::UTC);
                    }

                    $occurrences = array_merge($occurrences, $rrule->getOccurrencesBetween($rangeStart, $rangeEnd));
                }
            }
        }

        DateHelper::sortArrayOfDates($occurrences);

        return $occurrences;
    }

    /**
     * @return DateTimeUTC|null
     */
    public function getStartDateUTC()
    {
        if (is_null($this->startDate)) {
            return null;
        }

        $copy = new DateTimeUTC();
        $copy->setTimestamp($this->startDate->getTimestamp());

        return $copy;
    }

    /**
     * @return DateTimeUTC|null
     */
    public function getEndDateUTC()
    {
        if (is_null($this->endDate)) {
            return null;
        }

        $copy = new DateTimeUTC();
        $copy->setTimestamp($this->endDate->getTimestamp());

        return $copy;
    }

    /**
     * @return Carbon|null
     */
    public function getStartDateCarbon()
    {
        if (is_null($this->startDate)) {
            return null;
        }

        $carbon = Carbon::createFromTimestampUTC($this->startDate->getTimestamp());

        return $carbon;
    }

    /**
     * @return Carbon|null
     */
    public function getEndDateCarbon()
    {
        if (is_null($this->endDate)) {
            return null;
        }

        $carbon = Carbon::createFromTimestampUTC($this->endDate->getTimestamp());

        return $carbon;
    }

    /**
     * @return DateTimeUTC|null
     */
    public function getUntilUTC()
    {
        if (is_null($this->until)) {
            return null;
        }

        $copy = new DateTimeUTC();
        $copy->setTimestamp($this->until->getTimestamp());

        return $copy;
    }

    /**
     * @return Carbon|null
     */
    public function getUntilCarbon()
    {
        if (is_null($this->until)) {
            return null;
        }

        $carbon = Carbon::createFromTimestampUTC($this->until->getTimestamp());

        return $carbon;
    }

    /**
     * Returns the repeats ON rule, which could be -1, 1, 2, 3 or 4
     * Or 0 if no rule is set
     *
     * @return int
     */
    public function getRepeatsOnRule()
    {
        switch ($this->getFrequency()) {
            case RecurrenceHelper::MONTHLY:
            case RecurrenceHelper::YEARLY:
                $weekDays = $this->getRepeatsByWeekDays();
                if (empty($weekDays)) {
                    return 0;
                }

                $firstSymbol = substr($weekDays[0], 0, 1);
                if ($firstSymbol === '-') {
                    return -1;
                } elseif (is_numeric($firstSymbol)) {
                    return (int)$firstSymbol;
                }
                break;
        }

        return 0;
    }

    /**
     * Gets an array of week day 2 letter abbreviations if such a rule has been specified
     *
     * @return array|null
     */
    public function getRepeatsByWeekDays()
    {
        return $this->getArrayFromRRuleString($this->byDay);
    }

    /**
     * Strips off any "first", "second", "third", "fourth", "last" rules present in ::$byDay variable
     * and returns just the week days
     *
     * [-1SU,-1WE] becomes [SU,WE], etc.
     *
     * @return array
     */
    public function getRepeatsByWeekDaysAbsolute()
    {
        $weekDays = $this->getArrayFromRRuleString($this->byDay);

        if (!$weekDays) {
            return null;
        }

        $absoluteWeekDays = array_map(
            function ($value) {
                return preg_replace('/^-?[0-9]/', '', $value);
            },
            $weekDays
        );

        return $absoluteWeekDays;
    }

    /**
     * Gets an array of month day numbers if such a rule has been specified
     *
     * @return array|null
     */
    public function getRepeatsByMonthDays()
    {
        return $this->getArrayFromRRuleString($this->byMonthDay);
    }

    /**
     * Gets an array of month numbers if such a rule has been specified
     *
     * @return array|null
     */
    public function getRepeatsByMonths()
    {
        return $this->getArrayFromRRuleString($this->byMonth);
    }

    /**
     * Returns the RFC compliant RRULE string
     * Or NULL if no rule present
     *
     * @return string|null
     */
    public function getRRuleRFCString()
    {
        $rruleObject = $this->getRRuleObject();
        if ($rruleObject instanceof RRule) {
            return $rruleObject->rfcString();
        }

        return null;
    }

    /**
     * @return null|string
     */
    public function getHumanReadableRepeatsString()
    {
        if (!$this->repeats()) {
            return null;
        }

        $localeData    = craft()->i18n->getLocaleData(craft()->language);
        $dateFormatter = $localeData->getDateFormatter();
        $format        = $dateFormatter->getDatepickerPhpFormat();

        if ($this->repeatsOnSelectDates()) {
            $string = implode(", ", $this->getSelectDatesAsString($format));

            return $string;
        }

        $rruleObject = $this->getRRuleObject();

        if ($rruleObject) {
            $string = $rruleObject->humanReadable(
                array(
                    'date_formatter' => function (\DateTime $date) use ($format) {
                        return $date->format($format);
                    },
                )
            );

            $string = ucfirst($string);

            return $string;
        }

        return null;
    }

    /**
     * @return string
     */
    public function getUntilType()
    {
        if ($this->count) {
            return self::UNTIL_TYPE_COUNT;
        } else if ($this->until) {
            return self::UNTIL_TYPE_UNTIL;
        }

        return self::UNTIL_TYPE_FOREVER;
    }

    /**
     * @return bool
     */
    public function isInfinite()
    {
        return $this->getUntilType() === self::UNTIL_TYPE_FOREVER;
    }

    /**
     * @return bool
     */
    public function isFinite()
    {
        return !$this->isInfinite();
    }

    /**
     * Defines this model's attributes.
     *
     * @return array
     */
    protected function defineAttributes()
    {
        return array_merge(
            parent::defineAttributes(),
            array(
                'elementId'  => AttributeType::Number,
                'calendarId' => AttributeType::Number,
                'authorId'   => AttributeType::Number,
                'startDate'  => AttributeType::DateTime,
                'endDate'    => AttributeType::DateTime,
                'allDay'     => AttributeType::Bool,

                'rrule'      => AttributeType::String,
                'freq'       => AttributeType::String,
                'interval'   => AttributeType::Number,
                'count'      => AttributeType::Number,
                'until'      => AttributeType::DateTime,
                'byMonth'    => AttributeType::String,
                'byYearDay'  => AttributeType::String,
                'byMonthDay' => AttributeType::String,
                'byDay'      => AttributeType::String,
            )
        );
    }

    /**
     * Parses rules like "TU,WE,FR" and returns an array of [TU, WE, FR]
     * Returns NULL if the rule string is empty
     *
     * @param string $data
     *
     * @return array|null
     */
    private function getArrayFromRRuleString($data)
    {
        if (!$data) {
            return null;
        }

        return explode(',', $data);
    }

    /**
     * $countLimit is used for infinite recurrence rules when getting occurrences
     *
     * @return RRule
     */
    private function getRRuleObject()
    {
        if (!$this->getFrequency() || $this->repeatsOnSelectDates()) {
            return null;
        }

        return new RRule(
            array(
                'FREQ'       => $this->getFrequency(),
                'INTERVAL'   => $this->interval,
                'DTSTART'    => $this->getStartDateUTC(),
                'UNTIL'      => $this->getUntilUTC(),
                'COUNT'      => $this->count,
                'BYDAY'      => $this->byDay,
                'BYMONTHDAY' => $this->byMonthDay,
                'BYMONTH'    => $this->byMonth,
                'BYYEARDAY'  => $this->byYearDay,
            )
        );
    }
}
