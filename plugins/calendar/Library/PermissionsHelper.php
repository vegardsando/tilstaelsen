<?php

namespace Calendar\Library;

use Craft\Craft;

class PermissionsHelper
{
    const PERMISSION_CALENDARS        = 'calendar-manageCalendars';
    const PERMISSION_CREATE_CALENDARS = 'calendar-createCalendars';
    const PERMISSION_EDIT_CALENDARS   = 'calendar-editCalendars';
    const PERMISSION_DELETE_CALENDARS = 'calendar-deleteCalendars';

    const PERMISSION_EVENTS     = 'calendar-manageEvents';
    const PERMISSION_EVENTS_FOR = 'calendar-manageEventsFor';

    const PERMISSION_SETTINGS = 'calendar-settings';

    /**
     * Checks a given permission for the currently logged in user
     *
     * @param string $permissionName
     * @param bool   $checkForNested - see nested permissions for matching permission name root
     *
     * @return bool
     */
    public static function checkPermission($permissionName, $checkForNested = false)
    {
        $user           = \Craft\craft()->getUser();
        $permissionName = strtolower($permissionName);

        if (self::permissionsEnabled()) {
            if ($checkForNested) {
                $permissionList = \Craft\craft()->userPermissions->getPermissionsByUserId($user->getId());
                foreach ($permissionList as $permission) {
                    if (strpos($permission, $permissionName) === 0) {
                        return true;
                    }
                }
            }

            return $user->checkPermission($permissionName);
        } else {
            return self::isAdmin();
        }
    }

    /**
     * @param string $permissionName
     *
     * @return null
     * @throws \Craft\HttpException
     */
    public static function requirePermission($permissionName)
    {
        $user           = \Craft\craft()->getUser();
        $permissionName = strtolower($permissionName);

        return $user->requirePermission($permissionName);
    }

    /**
     * Fetches all nested allowed permission IDs from a nested permission set
     *
     * @param string $permissionName
     *
     * @return array
     */
    public static function getNestedPermissionIds($permissionName)
    {
        $user           = \Craft\craft()->getUser();
        $permissionName = strtolower($permissionName);
        $idList         = array();

        if (self::permissionsEnabled()) {
            $permissionList = \Craft\craft()->userPermissions->getPermissionsByUserId($user->getId());
            foreach ($permissionList as $permission) {
                if (strpos($permission, $permissionName) === 0) {
                    list($name, $id) = explode(':', $permission);

                    $idList[] = $id;
                }
            }

            return $idList;
        } else {
            return self::isAdmin();
        }
    }

    /**
     * Combines a nested permission with ID
     *
     * @param string $permissionName
     * @param int    $id
     *
     * @return string
     */
    public static function prepareNestedPermission($permissionName, $id)
    {
        return $permissionName . ':' . $id;
    }

    /**
     * Returns true if the currently logged in user is an admin
     *
     * @return bool
     */
    public static function isAdmin()
    {
        return \Craft\craft()->getUser()->isAdmin();
    }

    /**
     * @return bool
     */
    private static function permissionsEnabled()
    {
        $edition = \Craft\craft()->getEdition();

        return in_array($edition, array(Craft::Pro, Craft::Client));
    }
}
