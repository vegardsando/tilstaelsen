<?php

$plugin = array(
    'calendar_plugin_description'      => 'Izveidojiet kalendārus un atkārtojošos pasākumus.',
    'calendar_event_element_type_name' => 'Kalendāra pasākums',
);

$titles = array(
    'solspace_calendar'                 => 'Solspace Calendar',
    'solspace_calendar_view'            => 'Solspace Calendar: {view}',
    'solspace_calendar_calendars'       => 'Solspace Calendar: Kalendāri',
    'solspace_calendar_calendars_title' => 'Solspace Calendar: Kalendāri - {title}',
    'solspace_calendar_events'          => 'Solspace Calendar: Pasākumi',
    'solspace_calendar_events_title'    => 'Solspace Calendar: Pasākumi - {title}',
    'calendars'                         => 'Kalendāri',
    'settings'                          => 'Iestatījumi',
    'events'                            => 'Pasākumi',
    'new_calendar'                      => 'Izveidot kalendāru',
    'new_event'                         => 'Izveidot pasākumu',
    'demo_templates'                    => 'Demo Šabloni',

    'month' => 'Mēnesis',
    'week'  => 'Nedēļa',
    'day'   => 'Diena',
);

$widgets = array(
    // Common
    'calendar_widget_title'                  => 'Virsraksts',
    'calendar_widget_title_instructions'     => 'Personalizēt rīka virsrakstu. Atstājiet tukšu, lai būtu pēc noklusējuma.',
    'calendar_widget_calendars'              => 'Kalendāri',
    'calendar_widget_calendars_instructions' => 'Kuru kalendāru ierakstus jūs vēlaties parādīt?',

    // Agenda
    'calendar_widget_view'                   => 'Kalendāra skats',
    'calendar_widget_view_instructions'      => 'Izvēlaties kuru kalendāra skatu izmantot šajā rīkā',

    'calendar_agenda' => 'Kalendāra dienas kārtība',
    'quick_event'     => 'Ātrais pasākums',
    'mini_calendar'   => 'Mini kalendārs',
    'upcoming_events' => 'Tuvākie pasākumi',
);

$common = array(
    'save_and_continue_editing' => 'Saglabāt un turpināt rediģēt',
    'save_and_add_another'      => 'Saglabāt un pievienot jaunu',
);

$events = array(
    'event_title'         => 'Virsraksts',
    'event_slug'          => 'Slug',
    'event_author'        => 'Autors',
    'event_choose_author' => 'Izvēlēties',
    'event_enabled'       => 'Ieslēgts',
    'event_date_created'  => 'Izveidošanas datums',
    'event_date_updated'  => 'Rediģēšanas datums',

    'event_calendar'        => 'Kalendārs',
    'event_repeats'         => 'Atkārtojas',
    'event_repeats_every'   => 'Katru',
    'event_repeats_each'    => 'Katru',
    'event_repeats_on_the'  => 'Katru',
    'event_end_repeat'      => 'Beidz atkārtoties',
    'event_except_on'       => 'Izņemot',
    'event_select_dates_on' => 'Konkrētos datumos',

    'event_frequency_day'          => 'Dienu',
    'event_frequency_week'         => 'Nedēļu',
    'event_frequency_month'        => 'Mēnesi',
    'event_frequency_year'         => 'Gadu',
    'event_frequency_select_dates' => 'Konkrētos datumos',

    'event_repeats_by_first'  => 'Pirmo',
    'event_repeats_by_second' => 'Otro',
    'event_repeats_by_third'  => 'Trešo',
    'event_repeats_by_fourth' => 'Ceturto',
    'event_repeats_by_last'   => 'Pēdējo',

    'event_end_repeat_never_ends'  => 'Nekad',
    'event_end_repeat_on_date'     => 'Datumā',
    'event_end_repeat_after'       => 'Pēc',
    'event_end_repeat_after_times' => 'reizēm',

    'event_start_date' => 'Sākuma datums',
    'event_end_date'   => 'Beigu datums',
    'event_all_day'    => 'Visu dienu',

    'event_save'   => 'Saglabāt',
    'event_edit'   => 'Rediģēt',
    'event_cancel' => 'Atteikt',
    'event_limit'  => 'Ierobežojums',

    'event_delete'                          => 'Dzēst',
    'event_delete_confirmation'             => 'Vai tiešām vēlaties dzēst šo notikumu?',
    'event_delete_occurrence'               => 'Dzēst pasākuma notikumu',
    'event_delete_occurrence_confirmation'  => 'Vai tiešām?',
    'event_exception_delete_confirmation'   => 'Vai tiešām?',
    'event_select_date_delete_confirmation' => 'Vai tiešām?',

    'event_saved'       => 'Pasākums saglabāts.',
    'event_not_saved'   => 'Nevarēja saglabāt pasākumu.',
    'event_deleted'     => 'Pasākums dzēsts.',
    'event_not_deleted' => 'Nevarēja dzēst pasākumu.',

    'events_all_events'               => 'Visi pasākumi',
    'event_add_event'                 => 'Pievienot pasākumu',
    'event_delete_batch_confirmation' => 'Vai tiešām vēlaties dzēst izvēlētos notikumus?',
    'event_events_deleted'            => 'Pasākumi dzēsti.',

    'event_create'                             => 'Izveidot jaunu notikumu',
    'event_title_required'                     => 'Pasākuma virsraksts ir obligāts',
    'event_start_date_required'                => 'Pasākuma sākuma datums ir obligāts',
    'event_end_date_required'                  => 'Pasākuma beigu datums ir obligāts',
    'event_calendar_not_specified'             => 'Nav norādīts kalendārs',
    'event_calendar_does_not_exist'            => 'Norādītais kalendārs neeksistē',
    'event_slug_exists'                        => 'Slug jau eksistē',
    'could_not_delete_event'                   => 'Nevarēja dzēst pasākumu.',
    'event_not_found'                          => 'Pasākums netika atrasts',
    'event_id_not_found'                       => 'Nevarēja atrast pasākumu ar ID {id}',
    'event_end_repeat_date_required'           => 'Atkārtošanās beigu datums ir obligāts',
    'event_end_repeat_count_required'          => 'Atkārtošanās reižu skaits ir obligāts',
    'event_interval_must_be_a_positive_number' => 'Pasākuma intervālam jābūt pozitīvam skaitlim',
    'event_repeat_rules_not_specified'         => 'Event repeat rules not specified',
);

$calendars = array(
    'calendar_name'                     => 'Nosaukums',
    'calendar_name_instructions'        => 'Kalendāra nosaukums uzrādīsies kontorles panelī.',
    'calendar_handle'                   => 'Rokturis',
    'calendar_handle_instructions'      => 'Nosaukums pēc kura kalendārs tiks atrasts šablonos.',
    'calendar_description'              => 'Apraksts',
    'calendar_description_instructions' => 'Mazs apraksts par to, kam šis kalendārs ir paredzēts',
    'calendar_color'                    => 'Krāsa',
    'calendar_color_instructions'       => 'Pasākumi, kuri tiks pievienoti šim kalendāram izmantos šo krāsu',

    'calendar_save'                => 'Saglabāt',
    'calendar_delete'              => 'Dzēst',
    'calendar_delete_confirmation' => 'Vai tiešām vēlaties dzēst “{name}” kalendāru un visus tā pasākumus?',
    'calendar_refresh'             => 'Atjaunot',
    'calendar_create'              => 'Izveidot jaunu kalendāru',
    'no_calendars_present'         => 'Vēl nav izveidots neviens kalendārs.',

    'calendar_saved'            => 'Kalendārs saglabāts.',
    'calendar_not_saved'        => 'Nevarēja saglabāt kalendāru.',
    'calendar_handle_not_found' => 'Kalendārs ar rokturi "{handle}" netika atrasts',
    'calendar_id_not_found'     => 'Kalendārs ar ID "{id}" netika atrasts',
);

$demoTemplates = array(
    'demo_templates_prefix'    => 'Priedēklis',
    'demo_templates_install'   => 'Installēt',
    'demo_templates_templates' => 'Šabloni',
    'demo_templates_assets'    => 'Resursi',
    'demo_templates_routes'    => 'Ceļi',

    'no_demo_templates_present'   => 'Nav pieejamu demo šablonu',
    'demo_templates_installed'    => 'Veiksmīgi uzinstallēti <b>{templates} šabloni</b> un <b>{assets} resursi</b>',
    'view_demo_templates'         => 'Jūs varat apskatīt šablonus <a href="{link}">šeit</a>',
    'demo_templates_install_demo' => 'Installēt demo',
    'demo_templates_banner'       => 'Iedarbiniet kalendāru mājas lapā vien ar pāris klikšķiem! <a href="{link}" class="alert-link">Spiediet šeit, lai installētu demo šablonus.</a>',
);

$settings = array(
    'settings_date_overlap_threshold'               => 'Datumu pārklājuma slieksnis',
    'settings_date_overlap_threshold_instructions'  => 'Norādiet stundu skaitu nākamās dienas sākumā, kuras tiks uzskatītas par iepriekšējo dienu. Tas panāks to, ka vēlas nakts pasākumi neuzrādīsies nākamajā dienā.',
    'settings_time_interval'                        => 'Laika intervāls',
    'settings_time_interval_instructions'           => 'Laika izvēlnes intervāls minūtēs. Sākuma laika un beigu laika lauku izvēlnes saturēs sarakstu ar laikiem pa šādiem intervāliem.',
    'settings_event_duration'                       => 'Pasākuma noklusētais ilgums',
    'settings_event_duration_instructions'          => 'Noklusētais pasākuma ilgums minūtēs. Izvēloties sākuma datumu un laiku, šeit norādītais ilgums tiks pieskaitīts pie beigu datuma automātiski.',
    'settings_all_day_default'                      => 'Izvēlēties "Visu dienu" pēc noklusējuma?',
    'settings_all_day_default_instructions'         => 'Ieslēdzot šo parametru jauni pasākumi tiks izveidoti ar ieslēgtu "Visu dienu" izvēlni automātiski.',
    'settings_ics_description'                      => 'Apraksta lauks',
    'settings_ics_description_instructions'         => 'Izvēlaties, kurš lauks tiks izmantots pasākuma aprakstam eksportējot ICS formātā.',
    'settings_ics_location'                         => 'Pasākuma lokācijas lauks',
    'settings_ics_location_instructions'            => 'Izvēlaties, kurš lauks tiks izmantots pasākuma lokācijai eksportējot ICS formātā.',
    'settings_license_key'                          => 'Licences atslēga',
    'settings_license_key_instructions'             => 'Ievadiet savu licences atslēgu šajā laukā.',
    'settings_hide_demo_banner'                     => 'Paslēpt \'Installēt demo\' paziņojumu?',
    'settings_hide_demo_banner_instructions'        => 'Paslēpj paziņojumu, kurš piedāvā installēt demo šablonus, kad šī izvēlne ir ieslēgta.',
    'settings_no_description'                       => 'Neizmantot',
    'settings_no_location'                          => 'Neizmantot',
    'settings_display_mini_cal'                     => 'Parādīt mini kalendāra un kalendāra sarakstu mēneša/nedēļas/dienas skatos?',
    'settings_display_mini_cal_instructions'        => 'Parāda sānu izvēlni ar mini kalendāru un kalendāru sarakstu, ļaujot filtrēt pasākumus pēc kalendāra.',
    'settings_display_disabled_events'              => 'Iekļaut izslēgtos pasājumus mēneša/nedēļas/dienas skatos?',
    'settings_display_disabled_events_instructions' => 'Izslēgtie pasākumi tiks atrādīti kalendāra skatos caurspīdīgāki.',
    'no_calendar_setting_permissions'               => 'Jums nav pieejas kalendāra iestatījumiem.',

    'license'          => 'Licence',
    'event_settings'   => 'Pasākumu iestatījumi',
    'ics_settings'     => 'ICS iestatījumi',
    'field_layout'     => 'Lauku redaktors',
    'general_settings' => 'Galvenie iestatījumi',

    'settings_saved'     => 'Iestatījumi veiksmīgi saglabāti.',
    'settings_not_saved' => 'Nevarēja saglabāt iestatījumus.',
);

$permissions = array(
    'permissions_calendar_name' => '"{name}" kalendārs',
    'administrate_calendars'    => 'Administrēt kalendārus',
    'manage_events_in'          => 'Menedžēt pasākumus šādiem kalendāriem',
    'create_calendars'          => 'Izveidot kalendārus',
    'edit_calendars'            => 'Rediģēt kalendārus',
    'delete_calendars'          => 'Dzēst kalendārus',
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
