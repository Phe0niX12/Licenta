import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:mobile_ui/model/mail.dart';
import 'package:mobile_ui/model/event.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'calendar_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE mails(id TEXT PRIMARY KEY, subject TEXT, content TEXT, userEmail TEXT, userPassword TEXT, to TEXT, backgroundColor INTEGER, dateAndTimeSend TEXT, cc TEXT, bcc TEXT, dateAndTimeReminder TEXT)",
        ).then((_) {
          return db.execute(
            "CREATE TABLE events(id TEXT PRIMARY KEY, title TEXT, description TEXT, from TEXT, to TEXT, backgroundColor INTEGER)",
          );
        });
      },
      version: 1,
    );
  }

  // Mail operations
  Future<void> insertMail(Mail mail) async {
    final db = await database;
    await db.insert(
      'mails',
      mail.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Mail>> mails() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('mails');
    return List.generate(maps.length, (i) {
      return Mail.fromMap(maps[i]);
    });
  }

  Future<void> updateMail(Mail mail) async {
    final db = await database;
    await db.update(
      'mails',
      mail.toMap(),
      where: "id = ?",
      whereArgs: [mail.id],
    );
  }

  Future<void> deleteMail(String id) async {
    final db = await database;
    await db.delete(
      'mails',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Event operations
  Future<void> insertEvent(Event event) async {
    final db = await database;
    await db.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> events() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('events');
    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<void> updateEvent(Event event) async {
    final db = await database;
    await db.update(
      'events',
      event.toMap(),
      where: "id = ?",
      whereArgs: [event.id],
    );
  }

  Future<void> deleteEvent(String id) async {
    final db = await database;
    await db.delete(
      'events',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
