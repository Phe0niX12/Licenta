import 'package:flutter/material.dart';
import 'package:mobile_ui/model/event.dart';

class EventProvider extends ChangeNotifier{
  final List<Event> _events = [];

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  void addEvenet(Event event){
    _events.add(event);
    notifyListeners();
  }

  void deleteEvent(Event event){
    _events.removeWhere((element) => element == event,);
    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent){
    final index = _events.indexOf(oldEvent);
    _events[index]= newEvent;
    notifyListeners();
  }



}