var viewSpecificOptions = {
    week: {
        titleFormat: "MMMM D, YYYY",
        columnFormat: "ddd D",
        timeFormat: 'LT',
        slotLabelFormat: 'LT'
    },
    day: {
        titleFormat: 'dddd, MMMM D, YYYY',
        columnFormat: '',
        timeFormat: 'LT',
        slotLabelFormat: 'LT'
    }
};

var selectedCalendarsStorageKey = "calendar-selectedCalendars";
var qTipsEnabled = true;
var $calendar = $('#solspace-calendar');
var $miniCal = $("#calendar-mini-cal");

$(function () {
    "use strict";

    var defaultDay = new moment();
    if (typeof calendarCurrentDay !== "undefined") {
        defaultDay = new moment(calendarCurrentDay);
    }

    $calendar.fullCalendar({
        defaultDate: defaultDay,
        defaultView: $calendar.data('view'),
        nextDayThreshold: "0" + calendarOverlapThreshold + ":00:01",
        fixedWeekCount: true,
        eventLimit: 5,
        aspectRatio: 1.3,
        editable: canEditEvents,
        lang: calendarLocale,
        views: viewSpecificOptions,
        firstDay: calendarFirstDayOfWeek,
        viewRender: renderView,
        events: getEvents,
        eventRender: renderEvent,
        dayRender: renderDay,
        eventDragStart: closeAllQTips,
        eventDragStop: enableQTips,
        eventDrop: eventDateChange,
        eventResizeStart: closeAllQTips,
        eventResizeStop: enableQTips,
        eventResize: eventDurationChange,
        selectable: canEditEvents,
        selectHelper: canEditEvents,
        select: showEventCreator,
        unselectAuto: false,
        customButtons: {
            refresh: {
                text: Craft.t('calendar_refresh'),
                click: function () {
                    $calendar.fullCalendar('refetchEvents');
                }
            }
        },
        header: {
            right: 'refresh prev,today,next',
            left: 'title'
        }
    });

    if ($calendar.fullCalendar('getView').name !== 'month') {
        $calendar.fullCalendar('option', 'height', 'auto');
    }

    $('.fc-next-button, .fc-prev-button, .fc-today-button', $calendar).on({
        click: function () {
            var viewType = $calendar.fullCalendar('getView').type;
            var date = $calendar.fullCalendar('getDate');

            var year = date.format('YYYY');
            var month = date.format('MM');
            var day = date.format('DD');

            var view = 'month';
            switch (viewType) {
                case 'agendaDay':
                    view = 'day';
                    break;

                case 'agendaWeek':
                    view = 'week';
                    break;
            }

            var url = Craft.getCpUrl('calendar/view/' + view + '/' + year + '/' + month + '/' + day);

            history.pushState('data', '', url);
        }
    });

    $('.alert-dismissible a.close').on({
        click: function () {
            var $alert = $(this).parents(".alert:first");
            Craft.postActionRequest('calendar/view/dismissDemoAlert', {}, function (response) {
                $alert.remove();
            });
        }
    });

    $('.calendar-list input').on({
        change: function () {
            var calendarIds = $("ul.calendar-list input:checked").map(function () {
                return $(this).val();
            }).get().join();

            localStorage.setItem(selectedCalendarsStorageKey, calendarIds);

            $miniCal.data('calendars', calendarIds);
            $miniCal.fullCalendar("refetchEvents");

            $calendar.fullCalendar('refetchEvents');
        }
    });

    var $eventCreator = $('#event-creator');
    var $allDay = $('.lightswitch', $eventCreator);
    $allDay.on({
        change: function () {
            var $timeWrapper = $('.timewrapper', $eventCreator);

            if ($('input', this).val()) {
                $timeWrapper.fadeOut('fast');
            } else {
                $timeWrapper.fadeIn('fast');
            }
        }
    });
});

var selectedCalendars = localStorage.getItem(selectedCalendarsStorageKey);
if (selectedCalendars != null) {
    $miniCal.data('calendars', selectedCalendars);
    $miniCal.fullCalendar("refetchEvents");
    selectedCalendars = selectedCalendars.split(',');
    $(".calendar-list input").each(function () {
        var isSelected = selectedCalendars.indexOf($(this).val()) !== -1;
        $(this).prop('checked', isSelected);
    });
}
