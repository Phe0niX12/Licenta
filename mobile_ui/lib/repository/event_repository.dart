import 'package:mobile_ui/database/database_helper.dart';
import 'package:mobile_ui/model/event.dart';
import 'package:mobile_ui/services/event_service.dart';


class EventRepository {
  final DatabaseHelper _databaseHelper;
  final EventService _eventService;


  EventRepository(this._databaseHelper, this._eventService);

  Future<List<Event>> fetchLocalEvents() async {
    return await _databaseHelper.events();
  }

  Future<void> addEvent(Event event) async {
    await _databaseHelper.insertEvent(event);
  }

  Future<void> markEventAsDeleted(String eventId) async {
    await _databaseHelper.markEventAsDeleted(eventId);
  }
  Future<void> markEventAsUpdated(String eventId) async {
    await _databaseHelper.markEventAsUpdated(eventId);
  }

  Future<void> updateEvent(Event event) async {
    await _databaseHelper.updateEvent(event);

  }


  Future<void> deleteEvent(String eventId) async {
    await _databaseHelper.deleteEvent(eventId);
  }

  Future<void> syncEvents() async {
    final unsyncedEvents = await _databaseHelper.getUnsyncedEvents();
    final deletedEvents = await _databaseHelper.getDeletedEvents();
    final updatedEvents = await _databaseHelper.getUpdatedEvents(); // Fetch updated events

    // Sync unsynced events to the server
    for (final event in unsyncedEvents) {
      try {
        await _eventService.createEvent(event);
        await _databaseHelper.markEventAsSynced(event.id);
      } catch (e) {
        print('Error syncing event ${event.id}: $e');
      }
    }

    // Sync updated events to the server
    for (final event in updatedEvents) {
      try {
        await _eventService.updateEvent(event.id, event); // Update the event on the server
        await _databaseHelper.markEventAsSynced(event.id); // Mark the event as synced locally
      } catch (e) {
        print('Error updating event ${event.id}: $e');
      }
    }

    // Sync deleted events to the server
    for (final event in deletedEvents) {
      try {
        await _eventService.deleteEvent(event.id);
        await _databaseHelper.deleteEvent(event.id); // Remove the event from the local database
      } catch (e) {
        print('Error deleting event ${event.id}: $e');
      }
    }
    }

    Future<bool> isServerReachable() async {
      bool _isServerReackable = await _eventService.checkServerHealth();
      // Implement a simple request to check server connectivity
      return _isServerReackable;
    }

    Future<List<Event>> fetchRemoteEvents() async {
      return await _eventService.fetchEvents();
    }
}
