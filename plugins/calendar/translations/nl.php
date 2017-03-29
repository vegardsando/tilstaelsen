<?php

$plugin = array(
    'calendar_plugin_description'      => 'Create full-featured calendars and recurring events.',
    'calendar_event_element_type_name' => 'Calendar Events',
);

$titles = array(
    'solspace_calendar'                 => 'Solspace Calendar',
    'solspace_calendar_view'            => 'Solspace Calendar: {view}',
    'solspace_calendar_calendars'       => 'Solspace Calendar: Kalenders',
    'solspace_calendar_calendars_title' => 'Solspace Calendar: Kalenders - {title}',
    'solspace_calendar_events'          => 'Solspace Calendar: Evenementen',
    'solspace_calendar_events_title'    => 'Solspace Calendar: Evenementen - {title}',
    'calendars'                         => 'Kalenders',
    'settings'                          => 'Instellingen',
    'events'                            => 'Evenementen',
    'new_calendar'                      => 'Nieuwe kalender',
    'new_event'                         => 'Nieuw evenement',
    'demo_templates'                    => 'Voorbeeldjablonen',

    'month' => 'Maand',
    'week'  => 'Week',
    'day'   => 'Dag',
);

$widgets = array(
    // Common
    'calendar_widget_title'                  => 'Titel',
    'calendar_widget_title_instructions'     => 'Wijzig de widgettitel. Laat leeg voor standaardtitel.',
    'calendar_widget_calendars'              => 'Kalenders',
    'calendar_widget_calendars_instructions' => 'Welke kalenderitems wil je tonen?',

    // Agenda
    'calendar_widget_view'                   => 'Kalenderoverzicht',
    'calendar_widget_view_instructions'      => 'Kies welk type kalenderoverzicht je aan deze widget wil koppelen',

    'calendar_agenda' => 'Kalender agenda',
    'quick_event'     => 'Snel evenement',
    'mini_calendar'   => 'Mini kalender',
    'upcoming_events' => 'Toekomstige evenementen',
);

$common = array(
    'save_and_continue_editing' => 'Bewaren en bewerking voortzetten',
    'save_and_add_another'      => 'Bewaren en nog een toevoegen',
);

$events = array(
    'event_title'         => 'Titel',
    'event_slug'          => 'Slug',
    'event_author'        => 'Auteur',
    'event_choose_author' => 'Kies',
    'event_enabled'       => 'Ingeschakeld',
    'event_date_created'  => 'Datum gecreëerd',
    'event_date_updated'  => 'Datum geüpdate',

    'event_calendar'        => 'Kalender',
    'event_repeats'         => 'Herhaling',
    'event_repeats_every'   => 'Elke',
    'event_repeats_each'    => 'Elke',
    'event_repeats_on_the'  => 'Op de',
    'event_end_repeat'      => 'Eindig herhalen',
    'event_except_on'       => 'Behalve op',
    'event_select_dates_on' => 'Op geselecteerde data',

    'event_frequency_day'          => 'Dag(en)',
    'event_frequency_week'         => 'We(e)k(en)',
    'event_frequency_month'        => 'Maand(en)',
    'event_frequency_year'         => 'Ja(a)r(en)',
    'event_frequency_select_dates' => 'Selecteer data',

    'event_repeats_by_first'  => 'Eerste',
    'event_repeats_by_second' => 'Tweede',
    'event_repeats_by_third'  => 'Derde',
    'event_repeats_by_fourth' => 'Vierde',
    'event_repeats_by_last'   => 'Laatste',

    'event_end_repeat_never_ends'  => 'Eindigt nooit',
    'event_end_repeat_on_date'     => 'Op datum',
    'event_end_repeat_after'       => 'Na',
    'event_end_repeat_after_times' => 'keer',

    'event_start_date' => 'Begindatum',
    'event_end_date'   => 'Einddatum',
    'event_all_day'    => 'De hele dag',

    'event_save'   => 'Bewaar',
    'event_edit'   => 'Bewerk',
    'event_cancel' => 'Annuleer',
    'event_limit'  => 'Limiet',

    'event_delete'                          => 'Verwijder',
    'event_delete_confirmation'             => 'Ben je zeker dat je dit evenement wil verwijderen?',
    'event_delete_occurrence'               => 'Verwijder gebeurtenis',
    'event_delete_occurrence_confirmation'  => 'Ben je zeker?',
    'event_exception_delete_confirmation'   => 'Ben je zeker?',
    'event_select_date_delete_confirmation' => 'Ben je zeker?',

    'event_saved'       => 'Evenement bewaard.',
    'event_not_saved'   => 'Het evenement kon niet bewaard worden.',
    'event_deleted'     => 'Evenement verwijderd.',
    'event_not_deleted' => 'Het evenement kon niet verwijderd worden.',

    'events_all_events'               => 'Alle evenementen',
    'event_add_event'                 => 'Voeg een evenement toe',
    'event_delete_batch_confirmation' => 'Ben je zeker dat je de geselecteerde evenementen wil verwijderen?',
    'event_events_deleted'            => 'Evenementen verwijderd.',

    'event_create'                             => 'Maak een nieuw evenement',
    'event_title_required'                     => 'Evenementtitel is verplicht',
    'event_start_date_required'                => 'Begindatum evenement is verplicht',
    'event_end_date_required'                  => 'Einddatum evenement is verplicht',
    'event_calendar_not_specified'             => 'Geen kalender gekozen',
    'event_calendar_does_not_exist'            => 'De gekozen kalender bestaat niet',
    'event_slug_exists'                        => 'Slug bestaat al',
    'could_not_delete_event'                   => 'Het evenement kon niet verwijderd worden.',
    'event_not_found'                          => 'Het evenement kon niet gevonden worden.',
    'event_id_not_found'                       => 'Kon geen evenement vinden met ID {id}',
    'event_end_repeat_date_required'           => 'Einde herhalingsdatum moet gespecifieerd zijn',
    'event_end_repeat_count_required'          => 'Einde aantal herhalingen moet gespecifieerd zijn',
    'event_interval_must_be_a_positive_number' => 'Event interval must be a positive number',
    'event_repeat_rules_not_specified'         => 'Event repeat rules not specified',
);

$calendars = array(
    'calendar_name'                     => 'Naam',
    'calendar_name_instructions'        => 'Naam van deze kalender in het controlepaneel.',
    'calendar_handle'                   => 'Handle',
    'calendar_handle_instructions'      => 'Naam van deze kalender in de sjablonen.',
    'calendar_description'              => 'Beschrijving',
    'calendar_description_instructions' => 'Een korte beschrijving waar deze kalender over gaat',
    'calendar_color'                    => 'Kleur',
    'calendar_color_instructions'       => 'Evenementen in deze kalender zullen deze kleur hebben',

    'calendar_save'                => 'Bewaar',
    'calendar_delete'              => 'Verwijder',
    'calendar_delete_confirmation' => 'Ben je zeker dat je “{name}” en al zijn evenementen wil verwijderen?',
    'calendar_refresh'             => 'Vernieuwen',
    'calendar_create'              => 'Maak een nieuwe kalender',
    'no_calendars_present'         => 'Er zijn nog geen kalenders.',

    'calendar_saved'            => 'Kalender bewaard.',
    'calendar_not_saved'        => 'Deze kalender kon niet bewaard worden.',
    'calendar_handle_not_found' => 'De kalender met handle "{handle}" kon niet gevonden worden',
    'calendar_id_not_found'     => 'Er bestaat geen kalender met het ID "{id}"',
);

$demoTemplates = array(
    'demo_templates_prefix'    => 'Prefix',
    'demo_templates_install'   => 'Installeren',
    'demo_templates_templates' => 'Sjablonen',
    'demo_templates_assets'    => 'Bronnen',
    'demo_templates_routes'    => 'Routes',

    'no_demo_templates_present'   => 'Er zijn geen voorbeeldsjablonen beschikbaar',
    'demo_templates_installed'    => '<b>{templates} sjablonen</b> and <b>{assets} bronnen</b> geïnstalleerd',
    'view_demo_templates'         => 'Je kan de sjablonenen <a href="{link}">hier</a> bekijken',
    'demo_templates_install_demo' => 'Installeer voorbeeld',
    'demo_templates_banner'       => 'Begin met Calendar in de front end met enkele klikken! <a href="{link}" class="alert-link">Klik hier om de voorbeeldsjablonen te installeren.</a>',
);

$settings = array(
    'settings_date_overlap_threshold'               => 'Datumoverlapping',
    'settings_date_overlap_threshold_instructions'  => 'Selecteer hoeveel uren van de volgende dag nog beschouwd worden als uren van de vorige dag. Dat belet dat evenementen die laat op de avond zijn, op de volgende dag getoond worden.',
    'settings_time_interval'                        => 'Tijdsinterval',
    'settings_time_interval_instructions'           => 'Het tijdsinterval voor invulvelden met tijdskeuze. In minuten. De velden voor begintijd en eindtijd zullen uren tonen met dit interval.',
    'settings_event_duration'                       => 'Standaard lengte evenement',
    'settings_event_duration_instructions'          => 'De standaard lengte van een evenement. Als een beginuur geselecteerd wordt, zal dit aantal minuten automatisch opgeteld worden voor het einduur.',
    'settings_all_day_default'                      => 'Selecteer standaard "De hele dag"',
    'settings_all_day_default_instructions'         => 'Indien dit veld is geselecteerd, zullen nieuwe evenementen standaard een hele dag duren.',
    'settings_ics_description'                      => 'Beschrijvingveld',
    'settings_ics_description_instructions'         => 'Kies het veld dat gebruikt wordt voor de beschrijving van het evenement bij het exporteren naar ICS.',
    'settings_ics_location'                         => 'Locatieveld',
    'settings_ics_location_instructions'            => 'Kies het veld dat gebruikt wordt voor de locatie van het evenement bij het exporteren naar ICS.',
    'settings_license_key'                          => 'Licentienummer',
    'settings_license_key_instructions'             => 'Vul hier je Calendar licentienummer in.',
    'settings_hide_demo_banner'                     => 'Verberg \'Installeer voorbeeld\' bericht?',
    'settings_hide_demo_banner_instructions'        => 'Verbergt het bericht dat voorstelt om voorbeeldsjablonen te installeren.',
    'settings_no_description'                       => 'Geen',
    'settings_no_location'                          => 'Geen',
    'settings_display_mini_cal'                     => 'Toon minikalender & kalenderlijst in maand/week/dagoverzicht?',
    'settings_display_mini_cal_instructions'        => 'Toont een menu in de zijbalk met een minikalender en kalenderlijst waarmee gefilderd kan worden binnen evenementen.',
    'settings_display_disabled_events'              => 'Include Disabled Events in Month/Week/Day views?',
    'settings_display_disabled_events_instructions' => 'Events that are disabled will be displayed in the views with faded styles.',
    'no_calendar_setting_permissions'               => 'Je hebt geen rechten om de instellingen van Calendar te wijzigen.',

    'license'          => 'Licentie',
    'event_settings'   => 'Evenementinstellingen',
    'ics_settings'     => 'ICS-instellingen',
    'field_layout'     => 'Veldopmaak',
    'general_settings' => 'Algemene instellingen',

    'settings_saved'     => 'Instellingen succesvol bewaard.',
    'settings_not_saved' => 'De instellingen konden niet bewaard worden.',
);

$permissions = array(
    'permissions_calendar_name' => '"{name}" kalender',
    'administrate_calendars'    => 'Beheer kalenders',
    'manage_events_in'          => 'Beheer evenementen in',
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
