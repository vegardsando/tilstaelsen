<?php

namespace Craft;

use Calendar\Library\PermissionsHelper;

class Calendar_CalendarsController extends BaseController
{
    public function init()
    {
        PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_CALENDARS);

        parent::init();
    }

    /**
     * @throws HttpException
     */
    public function actionCalendarsIndex()
    {
        $variables['calendars'] = $this->getCalendarService()->getAllCalendars();

        $this->renderTemplate('calendar/calendars', $variables);
    }

    /**
     * @param array $variables
     *
     * @throws HttpException
     * @throws Exception
     */
    public function actionEditCalendar(array $variables = array())
    {
        $calendarHandle = isset($variables['calendarHandle']) ? $variables['calendarHandle'] : null;

        if (isset($variables['calendar']) && $variables['calendar'] instanceof Calendar_CalendarModel) {
            PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_EDIT_CALENDARS);

            $calendar = $variables['calendar'];
            $title    = $calendar->name;
        } elseif ($calendarHandle) {
            $calendar        = $this->getCalendarService()->getCalendarByHandle($calendarHandle);

            if (!$calendar) {
                throw new HttpException(
                    404,
                    Craft::t('calendar_handle_not_found', array('handle' => $calendarHandle))
                );
            }

            PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_EDIT_CALENDARS);

            $title = $calendar->name;
        } else {
            PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_CREATE_CALENDARS);

            $calendar = Calendar_CalendarModel::create();
            $title    = Craft::t('calendar_create');
        }

        $variables['title']              = $title;
        $variables['calendar']           = $calendar;
        $variables['continueEditingUrl'] = 'calendar/calendars/{handle}';

        $this->renderTemplate('calendar/calendars/_edit', $variables);
    }

    /**
     * Saves a calendar
     */
    public function actionSaveCalendar()
    {
        $this->requirePostRequest();


        $calendar = new Calendar_CalendarModel();

        $postedCalendarId      = craft()->request->getPost('calendarId');
        if ($postedCalendarId) {
            PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_EDIT_CALENDARS);
        } else {
            PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_CREATE_CALENDARS);
        }

        // Shared attributes
        $calendar->id          = $postedCalendarId;
        $calendar->name        = craft()->request->getPost('name');
        $calendar->handle      = craft()->request->getPost('handle');
        $calendar->description = craft()->request->getPost('description');
        $calendar->color       = craft()->request->getPost('color');

        // Save it
        if ($this->getCalendarService()->saveCalendar($calendar)) {
            craft()->userSession->setNotice(Craft::t('calendar_saved'));
            $this->redirectToPostedUrl($calendar);
        } else {
            // Send the calendar back to the template
            craft()->urlManager->setRouteVariables(array('calendar' => $calendar));

            craft()->userSession->setError(Craft::t('calendar_not_saved'));
        }
    }

    /**
     * @throws HttpException
     * @throws \Exception
     */
    public function actionDelete()
    {
        $this->requirePostRequest();
        $this->requireAjaxRequest();

        PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_DELETE_CALENDARS);

        $calendarId = craft()->request->getRequiredPost('id');

        if ($this->getCalendarService()->deleteCalendarById($calendarId)) {
            $this->returnJson(array('success' => true));
        } else {
            $this->returnJson(array('success' => false));
        }
    }

    /**
     * @return Calendar_CalendarsService
     */
    private function getCalendarService()
    {
        return craft()->calendar_calendars;
    }
}
