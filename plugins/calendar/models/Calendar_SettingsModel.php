<?php

namespace Craft;

/**
 * @property int    $overlapThreshold
 * @property int    $timeInterval
 * @property int    $eventDuration
 * @property bool   $allDay
 * @property string $descriptionFieldHandle
 * @property string $locationFieldHandle
 * @property bool   $demoBannerDisabled
 * @property string $license
 * @property bool   $showMiniCal
 * @property bool   $showDisabledEvents
 */
class Calendar_SettingsModel extends BaseModel
{
    const DEFAULT_DATE_OVERLAP_THRESHOLD = 5;
    const DEFAULT_TIME_INTERVAL          = 30;
    const DEFAULT_DURATION               = 60;
    const DEFAULT_ALL_DAY                = false;
    const DEFAULT_SHOW_MINI_CAL          = true;
    const DEFAULT_SHOW_DISABLED_EVENTS   = true;

    private static $overlapThresholds = array(
        0 => 0,
        1 => 1,
        2 => 2,
        3 => 3,
        4 => 4,
        5 => 5,
    );

    private static $timeIntervals = array(
        15 => 15,
        30 => 30,
        60 => 60,
    );

    private static $eventDurations = array(
        30  => 30,
        60  => 60,
        120 => 120,
    );

    /**
     * Setting default values upon construction
     *
     * @param null $attributes
     */
    public function __construct($attributes = null)
    {
        parent::__construct($attributes);

        $this->overlapThreshold       = self::DEFAULT_DATE_OVERLAP_THRESHOLD;
        $this->timeInterval           = self::DEFAULT_TIME_INTERVAL;
        $this->eventDuration          = self::DEFAULT_DURATION;
        $this->allDay                 = self::DEFAULT_ALL_DAY;
        $this->descriptionFieldHandle = null;
        $this->locationFieldHandle    = null;
        $this->demoBannerDisabled     = null;
        $this->showMiniCal            = self::DEFAULT_SHOW_MINI_CAL;
    }

    /**
     * @return array
     */
    public static function getOverlapThresholds()
    {
        return self::$overlapThresholds;
    }

    /**
     * @return array
     */
    public static function getTimeIntervals()
    {
        return self::$timeIntervals;
    }

    /**
     * @return array
     */
    public static function getEventDurations()
    {
        return self::$eventDurations;
    }

    /**
     * @return array
     */
    public function getDescriptionFieldHandles()
    {
        $fieldList = array(Craft::t('settings_no_description'));
        foreach ($this->getFieldLayout()->getFields() as $fieldModel) {
            $field = $fieldModel->getField();

            $fieldList[$field->handle] = $field->name;
        }

        return $fieldList;
    }

    /**
     * @return array
     */
    public function getLocationFieldHandles()
    {
        $fieldList = array(Craft::t('settings_no_location'));
        foreach ($this->getFieldLayout()->getFields() as $fieldModel) {
            $field = $fieldModel->getField();

            $fieldList[$field->handle] = $field->name;
        }

        return $fieldList;
    }

    /**
     * @return array
     */
    public function rules()
    {
        $rules = parent::rules();

        return $rules;
    }

    /**
     * @return FieldLayoutModel
     */
    public function getFieldLayout()
    {
        return craft()->fields->getLayoutByType(CalendarPlugin::FIELD_LAYOUT_TYPE);
    }

    /**
     * @return bool
     */
    public function isDemoBannerDisabled()
    {
        return $this->demoBannerDisabled == true;
    }

    /**
     * @return bool
     */
    public function isMiniCalEnabled()
    {
        return (bool)$this->showMiniCal;
    }

    /**
     * @return array
     */
    protected function defineAttributes()
    {
        return array(
            'overlapThreshold'       => array(AttributeType::Enum, 'values' => self::$overlapThresholds),
            'timeInterval'           => array(AttributeType::Enum, 'values' => self::$timeIntervals),
            'eventDuration'          => array(AttributeType::Enum, 'values' => self::$eventDurations),
            'allDay'                 => array(AttributeType::Bool, 'default' => self::DEFAULT_ALL_DAY),
            'descriptionFieldHandle' => array(AttributeType::Slug, 'default' => null),
            'locationFieldHandle'    => array(AttributeType::Slug, 'default' => null),
            'demoBannerDisabled'     => array(AttributeType::Bool, 'default' => null),
            'license'                => array(AttributeType::String, 'default' => null),
            'showMiniCal'            => array(AttributeType::Bool, 'default' => self::DEFAULT_SHOW_MINI_CAL),
            'showDisabledEvents'     => array(AttributeType::Bool, 'default' => self::DEFAULT_SHOW_DISABLED_EVENTS),
        );
    }
}
