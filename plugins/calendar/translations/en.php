<?php

$plugin = array(
    'calendar_plugin_description'      => 'Create full-featured calendars and recurring events.',
    'calendar_event_element_type_name' => 'Calendar Events',
);

$titles = array(
    'solspace_calendar'                 => 'Solspace Calendar',
    'solspace_calendar_view'            => 'Solspace Calendar: {view}',
    'solspace_calendar_calendars'       => 'Solspace Calendar: Calendars',
    'solspace_calendar_calendars_title' => 'Solspace Calendar: Calendars - {title}',
    'solspace_calendar_events'          => 'Solspace Calendar: Events',
    'solspace_calendar_events_title'    => 'Solspace Calendar: Events - {title}',
    'calendars'                         => 'Calendars',
    'settings'                          => 'Settings',
    'events'                            => 'Events',
    'new_calendar'                      => 'New Calendar',
    'new_event'                         => 'New Event',
    'demo_templates'                    => 'Demo Templates',

    'month' => 'Month',
    'week'  => 'Week',
    'day'   => 'Day',
);

$widgets = array(
    // Common
    'calendar_widget_title'                  => 'Title',
    'calendar_widget_title_instructions'     => 'Customise the widget title. Leave blank for default.',
    'calendar_widget_calendars'              => 'Calendars',
    'calendar_widget_calendars_instructions' => 'Which calendar entries do you wish to show?',

    // Agenda
    'calendar_widget_view'                   => 'Calendar View',
    'calendar_widget_view_instructions'      => 'Choose which type of calendar view to assign to this widget',

    'calendar_agenda' => 'Calendar Agenda',
    'quick_event'     => 'Quick Event',
    'mini_calendar'   => 'Mini Calendar',
    'upcoming_events' => 'Upcoming Events',
);

$common = array(
    'save_and_continue_editing' => 'Save and continue editing',
    'save_and_add_another'      => 'Save and add another',
);

$events = array(
    'event_title'         => 'Title',
    'event_slug'          => 'Slug',
    'event_author'        => 'Author',
    'event_choose_author' => 'Choose',
    'event_enabled'       => 'Enabled',
    'event_date_created'  => 'Date Created',
    'event_date_updated'  => 'Date Updated',

    'event_calendar'        => 'Calendar',
    'event_repeats'         => 'Repeats',
    'event_repeats_every'   => 'Every',
    'event_repeats_each'    => 'Each',
    'event_repeats_on_the'  => 'On the',
    'event_end_repeat'      => 'End repeat',
    'event_except_on'       => 'Except on',
    'event_select_dates_on' => 'On select dates',

    'event_frequency_day'          => 'Day(s)',
    'event_frequency_week'         => 'Week(s)',
    'event_frequency_month'        => 'Month(s)',
    'event_frequency_year'         => 'Year(s)',
    'event_frequency_select_dates' => 'Select dates',

    'event_repeats_by_first'  => 'First',
    'event_repeats_by_second' => 'Second',
    'event_repeats_by_third'  => 'Third',
    'event_repeats_by_fourth' => 'Fourth',
    'event_repeats_by_last'   => 'Last',

    'event_end_repeat_never_ends'  => 'Never ends',
    'event_end_repeat_on_date'     => 'On date',
    'event_end_repeat_after'       => 'After',
    'event_end_repeat_after_times' => 'times',

    'event_start_date' => 'Start Date',
    'event_end_date'   => 'End Date',
    'event_all_day'    => 'All Day',

    'event_save'   => 'Save',
    'event_edit'   => 'Edit',
    'event_cancel' => 'Cancel',
    'event_limit'  => 'Limit',

    'event_delete'                          => 'Delete',
    'event_delete_confirmation'             => 'Are you sure you want to delete this event?',
    'event_delete_occurrence'               => 'Delete occurrence',
    'event_delete_occurrence_confirmation'  => 'Are you sure?',
    'event_exception_delete_confirmation'   => 'Are you sure?',
    'event_select_date_delete_confirmation' => 'Are you sure?',

    'event_saved'       => 'Event saved.',
    'event_not_saved'   => 'Couldn’t save event.',
    'event_deleted'     => 'Event deleted.',
    'event_not_deleted' => 'Couldn’t delete event.',

    'events_all_events'               => 'All events',
    'event_add_event'                 => 'Add an event',
    'event_delete_batch_confirmation' => 'Are you sure you want to delete the selected events?',
    'event_events_deleted'            => 'Events deleted.',

    'event_create'                             => 'Create a new event',
    'event_title_required'                     => 'Event title is required',
    'event_start_date_required'                => 'Event start date is required',
    'event_end_date_required'                  => 'Event end date is required',
    'event_calendar_not_specified'             => 'Calendar not specified',
    'event_calendar_does_not_exist'            => 'The specified calendar does not exist',
    'event_slug_exists'                        => 'Slug already exists',
    'could_not_delete_event'                   => 'Couldn’t delete event.',
    'event_not_found'                          => 'Event could not be found',
    'event_id_not_found'                       => 'Could not find an Event with ID {id}',
    'event_end_repeat_date_required'           => 'End repeat date must be specified',
    'event_end_repeat_count_required'          => 'End repeat count must be specified',
    'event_interval_must_be_a_positive_number' => 'Event interval must be a positive number',
    'event_repeat_rules_not_specified'         => 'Event repeat rules not specified',
);

$calendars = array(
    'calendar_name'                     => 'Name',
    'calendar_name_instructions'        => 'What this calendar will be called in the CP.',
    'calendar_handle'                   => 'Handle',
    'calendar_handle_instructions'      => 'How you’ll refer to this calendar in the templates.',
    'calendar_description'              => 'Description',
    'calendar_description_instructions' => 'A small description describing what this calendar is about',
    'calendar_color'                    => 'Color',
    'calendar_color_instructions'       => 'Events assigned to this calendar will use this color',

    'calendar_save'                => 'Save',
    'calendar_delete'              => 'Delete',
    'calendar_delete_confirmation' => 'Are you sure you want to delete “{name}” and all its events?',
    'calendar_refresh'             => 'Refresh',
    'calendar_create'              => 'Create a new calendar',
    'no_calendars_present'         => 'No calendars exist yet.',

    'calendar_saved'            => 'Calendar saved.',
    'calendar_not_saved'        => 'Couldn’t save calendar.',
    'calendar_handle_not_found' => 'Calendar with a handle "{handle}" could not be found',
    'calendar_id_not_found'     => 'No calendar exists with the ID "{id}"',
);

$demoTemplates = array(
    'demo_templates_prefix'    => 'Prefix',
    'demo_templates_install'   => 'Install',
    'demo_templates_templates' => 'Templates',
    'demo_templates_assets'    => 'Assets',
    'demo_templates_routes'    => 'Routes',

    'no_demo_templates_present'   => 'There are no Demo Templates available',
    'demo_templates_installed'    => 'Successfully installed <b>{templates} templates</b> and <b>{assets} assets</b>',
    'view_demo_templates'         => 'You can view the templates <a href="{link}">here</a>',
    'demo_templates_install_demo' => 'Install Demo',
    'demo_templates_banner'       => 'Get Calendar up and running on the front end with just a couple clicks! <a href="{link}" class="alert-link">Click here to install the Demo templates.</a>',
);

$settings = array(
    'settings_date_overlap_threshold'               => 'Date Overlap Threshold',
    'settings_date_overlap_threshold_instructions'  => 'Specify the amount of hours in the next day which are still considered as those of the previous day. This prevents late night events from showing up the next day for calendars in control panel and front end.',
    'settings_time_interval'                        => 'Time Interval',
    'settings_time_interval_instructions'           => 'The time picker interval for fieldtype, in minutes. The Start Time and End Time field time pickers will contain a list of times of the day by this interval.',
    'settings_event_duration'                       => 'Default Event Duration',
    'settings_event_duration_instructions'          => 'The default event time duration for fieldtype, in minutes. When event Start Time is selected, this number of minutes will automatically be added to that time for End Time field.',
    'settings_all_day_default'                      => 'Select "All Day" by default?',
    'settings_all_day_default_instructions'         => 'When enabled, when creating new events the \'All Day\' option will be selected by default.',
    'settings_ics_description'                      => 'Description field',
    'settings_ics_description_instructions'         => 'Set the custom field which is used for event description in ICS exports.',
    'settings_ics_location'                         => 'Location field',
    'settings_ics_location_instructions'            => 'Set the custom field which is used for event location in ICS exports.',
    'settings_license_key'                          => 'License key',
    'settings_license_key_instructions'             => 'Enter your Calendar license key here.',
    'settings_hide_demo_banner'                     => 'Hide \'Install Demo\' alert message?',
    'settings_hide_demo_banner_instructions'        => 'Hides the alert message suggesting to install demo templates when this setting is enabled.',
    'settings_no_description'                       => 'None',
    'settings_no_location'                          => 'None',
    'settings_display_mini_cal'                     => 'Display Mini Calendar & Calendars list in Month/Week/Day views?',
    'settings_display_mini_cal_instructions'        => 'Displays a side menu with mini calendar and list of calendars, allowing you to filter your event results.',
    'settings_display_disabled_events'              => 'Include Disabled Events in Month/Week/Day views?',
    'settings_display_disabled_events_instructions' => 'Events that are disabled will be displayed in the views with faded styles.',
    'no_calendar_setting_permissions'               => 'You don’t have permission to access Calendar Settings.',

    'license'          => 'License',
    'event_settings'   => 'Event Settings',
    'ics_settings'     => 'ICS Settings',
    'field_layout'     => 'Field Layout',
    'general_settings' => 'General Settings',

    'settings_saved'     => 'Settings saved successfully.',
    'settings_not_saved' => 'Could not save settings.',
);

$permissions = array(
    'permissions_calendar_name' => '"{name}" calendar',
    'administrate_calendars'    => 'Administrate Calendars',
    'manage_events_in'          => 'Manage events in',
    'create_calendars'          => 'Create Calendars',
    'edit_calendars'            => 'Edit Calendars',
    'delete_calendars'          => 'Delete Calendars',
);

return array_merge(
    $plugin,
    $titles,
    $widgets,
    $common,
    $events,
    $calendars,
    $demoTemplates,
    $settings,
    $permissions
);
