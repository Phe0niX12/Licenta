import 'package:flutter/material.dart';
import 'package:mobile_ui/main.dart';
import 'package:mobile_ui/ui/event_editing_pange.dart';
import 'package:mobile_ui/ui/mail_editing_page.dart';
import 'package:mobile_ui/widget/calendar_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Calendar App"),
      centerTitle: true,
      actions: [ ElevatedButton.icon(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MailEditingPage())),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(0, 79, 5, 92),
          shadowColor: const Color.fromARGB(0, 79, 5, 92),
          side: BorderSide(
            width: 1.0,
            color: Colors.black
          )
        ),
        icon: Icon(Icons.email),
        label: Text("Email"),
        )],
    ),
    body: CalendarWidget(),
    floatingActionButton: FloatingActionButton(
      child: Icon(
        Icons.add,
        color: Colors.white, 
      ),
      backgroundColor: Colors.red,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EventEditingPage())
      ),
    ),
  );
}

