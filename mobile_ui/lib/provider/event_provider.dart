import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:mobile_ui/database/database_helper.dart';
import 'package:mobile_ui/model/event.dart';

class EventProvider extends ChangeNotifier{
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final List<Event> _events = [];

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  Future<void> loadEvents() async{
    _events.clear();
    final eventList = await _databaseHelper.events();
    _events.addAll(eventList);
    notifyListeners();
  }
  Future<void> addEvenet(Event event)async{
    await _databaseHelper.insertEvent(event);
    _events.add(event);
    notifyListeners();
  }

  Future<void> deleteEvent(Event event)async{
    await _databaseHelper.deleteEvent(event.id);
    _events.removeWhere((element) => element == event,);
    notifyListeners();
  }

  Future<void> editEvent(Event newEvent, Event oldEvent)async{
    await _databaseHelper.updateEvent(
      newEvent
    );
    final index = _events.indexOf(oldEvent);
    _events[index]= newEvent;
    notifyListeners();
  }



}