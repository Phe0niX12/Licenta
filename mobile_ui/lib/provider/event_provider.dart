import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ui/database/database_helper.dart';
import 'package:mobile_ui/model/event.dart';
import 'package:mobile_ui/repository/event_repository.dart';

class EventProvider extends ChangeNotifier{
  final EventRepository _eventRepository;

  final List<Event> _events = [];
  bool _isSyncing=false;

  EventProvider(this._eventRepository){
    _loadEvents();
  }

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  Future<void> _loadEvents() async {
    _events.clear();
    final eventList = await _eventRepository.fetchLocalEvents();
    if(eventList.isEmpty){
      final eventsServer = await _eventRepository.fetchRemoteEvents();
      _events.addAll(eventsServer);
      notifyListeners();
    }else{// Load from DB
      _events.addAll(eventList);
      notifyListeners();
    }
  }

  Future<void> addEvenet(Event event)async{
    await _eventRepository.addEvent(event);
    _events.add(event);
    notifyListeners();
    _syncWithServer();
  }

  Future<void> deleteEvent(Event event) async {
    await _eventRepository.markEventAsDeleted(event.id); // Delete from DB
    _events.removeWhere((element) => element.id == event.id);
    notifyListeners();
    _syncWithServer();
  }

  Future<void> editEvent(Event newEvent, Event oldEvent) async {
    await _eventRepository.markEventAsUpdated(newEvent.id);
    await _eventRepository.updateEvent(newEvent); // Update in DB
    final index = _events.indexWhere((event) => event.id == oldEvent.id);
    if (index != -1) {
      _events[index] = newEvent;
      notifyListeners();
      _syncWithServer();
    }
  }

  Future<void> _syncWithServer() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print('No internet connection. Sync deferred.');
      return;
    }

    _isSyncing = true;
    notifyListeners();

    try {
      if (await _eventRepository.isServerReachable()) {
        await _eventRepository.syncEvents();
        await _loadEvents();
      } else {
        print('Server is not reachable. Sync deferred.');
      }
    } catch (e) {
      print('Error during sync: $e');
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }


}