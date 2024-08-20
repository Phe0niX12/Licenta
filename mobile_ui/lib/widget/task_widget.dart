import 'package:flutter/material.dart';
import 'package:mobile_ui/model/event_data_source.dart';
import 'package:mobile_ui/provider/event_provider.dart';
import 'package:mobile_ui/ui/event_viewing_page.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TaskWidget extends StatefulWidget {
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return Center(
        child: Text(
          'No events found!',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }

    Widget appointmentBuilder(
        BuildContext context, CalendarAppointmentDetails details) {
      final event = details.appointments.first;

      return Container(
          width: details.bounds.width,
          height: details.bounds.height,
          decoration: BoxDecoration(
            color: event.backgroundColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Center(
              child: Text(
                event.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
          )
      );
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.purpleAccent
        )
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.purpleAccent,
        selectionDecoration: BoxDecoration(
          color: Colors.red.withOpacity(0.3)
        ),
        onTap: (details) {
          if(details.appointments == null) return;

          final event = details.appointments!.first;

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventViewingPage(event:event)));

        },
      ),
    );
  }
}
