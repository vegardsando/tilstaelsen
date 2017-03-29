<?php

namespace Craft;

use Calendar\Library\PermissionsHelper;

class Calendar_SettingsController extends BaseController
{
    /**
     * Make sure this controller requires a logged in member
     */
    public function init()
    {
        $this->requireLogin();
    }

    /**
     * Renders the License settings page template
     */
    public function actionLicense()
    {
        $this->provideTemplate('license');
    }

    /**
     * Renders the General settings page template
     */
    public function actionGeneral()
    {
        $this->provideTemplate('general');
    }

    /**
     * Renders the Events settings page template
     */
    public function actionEvents()
    {
        $this->provideTemplate('events');
    }

    /**
     * Renders the ICS settings page template
     */
    public function actionIcs()
    {
        $this->provideTemplate('ics');
    }

    /**
     * Renders the Field Layout settings page template
     */
    public function actionFieldLayout()
    {
        $this->provideTemplate('field_layout');
    }

    /**
     * Handles layout saving and ICS field special treatment if necessery
     *
     * @throws HttpException
     */
    public function actionSaveSettings()
    {
        PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_SETTINGS);

        $this->requirePostRequest();
        $postData     = craft()->request->getPost('settings', array());
        $updateLayout = craft()->request->getPost('update_layout', false);

        if ($updateLayout) {
            $this->savePostedLayout();
        }

        $this->handleIcsFields($postData);

        $plugin = craft()->plugins->getPlugin('calendar');
        craft()->plugins->savePluginSettings($plugin, $postData);

        craft()->userSession->setNotice(Craft::t('settings_saved'));
        $this->redirectToPostedUrl();
    }

    /**
     * Checks the field layout for ICS description and location fields
     * If they aren't in the field layout anymore
     * They get removed from the ICS field values
     *
     * @param array $postData
     */
    private function handleIcsFields(array &$postData)
    {
        $settingsModel = $this->getSettingsModel();
        $fieldLayout   = $settingsModel->getFieldLayout();

        if ($fieldLayout) {
            $fieldHandles = array();
            foreach ($fieldLayout->getFields() as $field) {
                $fieldHandles[] = $field->getField()->handle;
            }

            $descriptionFieldHandle = $settingsModel->descriptionFieldHandle;
            $locationFieldHandle    = $settingsModel->locationFieldHandle;

            if ($descriptionFieldHandle && !in_array($descriptionFieldHandle, $fieldHandles)) {
                $postData['descriptionFieldHandle'] = null;
            }

            if ($locationFieldHandle && !in_array($locationFieldHandle, $fieldHandles)) {
                $postData['locationFieldHandle'] = null;
            }
        }
    }

    /**
     * Removes the previous layout and saves the new one from POST
     */
    private function savePostedLayout()
    {
        $fieldLayout = craft()->request->getPost('fieldLayout');
        craft()->fields->deleteLayoutsByType(CalendarPlugin::FIELD_LAYOUT_TYPE);

        // Only deal with layout if it's posted.
        if ($fieldLayout) {
            $fieldLayout       = craft()->fields->assembleLayoutFromPost();
            $fieldLayout->type = CalendarPlugin::FIELD_LAYOUT_TYPE;
            craft()->fields->saveLayout($fieldLayout);
        }
    }

    /**
     * Determines which template has to be rendered based on $template
     * Adds a Calendar_SettingsModel to template variables
     *
     * @param string $template
     *
     * @throws HttpException
     */
    private function provideTemplate($template)
    {
        PermissionsHelper::requirePermission(PermissionsHelper::PERMISSION_SETTINGS);

        $this->renderTemplate(
            'calendar/settings/_' . $template,
            array(
                'settings' => $this->getSettingsModel(),
            )
        );
    }

    /**
     * @return Calendar_SettingsModel
     */
    private function getSettingsModel()
    {
        /** @var Calendar_SettingsService $settingsService */
        $settingsService = craft()->calendar_settings;

        return $settingsService->getSettingsModel();
    }
}
