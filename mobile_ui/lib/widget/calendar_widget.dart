import 'package:flutter/material.dart';
import 'package:mobile_ui/model/calendar_item.dart';
import 'package:mobile_ui/model/calendar_data_source_extended.dart.dart';
import 'package:mobile_ui/provider/event_provider.dart';
import 'package:mobile_ui/provider/mail_provider.dart';
import 'package:mobile_ui/widget/task_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    final mails = Provider.of<MailProvider>(context).mails;
    
    final allItems = [...events, ...mails];
    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      dataSource: CalendarDataSourceExtended(allItems),
      onLongPress: (details) {
        final providerEvents = Provider.of<EventProvider>(context, listen: false);
        final providerMails = Provider.of<MailProvider>(context, listen: false);
        providerEvents.setDate(details.date!);
        providerMails.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => TaskWidget(),
          );
      },
    );
  }
}