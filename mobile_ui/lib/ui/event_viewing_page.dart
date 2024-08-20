import 'package:flutter/material.dart';
import 'package:mobile_ui/model/event.dart';
import 'package:mobile_ui/provider/event_provider.dart';
import 'package:mobile_ui/ui/event_editing_pange.dart';
import 'package:mobile_ui/utils/utils.dart';
import 'package:provider/provider.dart';


class EventViewingPage extends StatelessWidget {
  final Event event;

  const EventViewingPage({
    Key? key,
    required this.event,
  }):super(key: key);

  Widget buildDateTime(Event event){
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From', event.from),
        if(!event.isAllDay) buildDate('To', event.to),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: CloseButton(),
      actions: buildViewingActions(context,event),
    ),
    body: ListView(
      padding: EdgeInsets.all(32),
      children: <Widget>[
        buildDateTime(event),
        SizedBox(height: 32),
        Text(
          event.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24,),
        Text(
          event.description,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
        )
      ],
    ),
  );
  
  List<Widget> buildViewingActions(BuildContext context, Event event) => [
    IconButton(
      onPressed: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => EventEditingPage(event: event,)
          )
      ), 
      icon: Icon(Icons.edit)
      ),
      IconButton(
        onPressed: () {
          final provider = Provider.of<EventProvider>(context, listen: false);
          provider.deleteEvent(event);
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.delete)
      )
  ];
  
  buildDate(String title, DateTime date) => buildHeader(
    header: title, 
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            Utils.toDate(date)
          )
        ),
        Expanded(
          flex: 2,
          child: Text(
            Utils.toTime(date)
          )
        )
      ],
      )
    
    );

  Widget buildHeader({
    required String header,
    required Widget child
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(header, style: TextStyle(fontWeight: FontWeight.bold),),
      child
    ],
  );
}