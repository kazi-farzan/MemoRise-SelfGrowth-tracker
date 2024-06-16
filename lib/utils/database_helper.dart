import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:memorise/models/mood_entry.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'mood_entries.db';
  static const String _tableName = 'mood_entries';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        mood TEXT NOT NULL,
        note TEXT,
        activities TEXT
      )
    ''');
  }

  Future<int> insertMoodEntry(MoodEntry entry) async {
    Database db = await database;
    return await db.insert(_tableName, entry.toMap());
  }

  Future<List<MoodEntry>> getAllMoodEntries() async {
    Database db = await database;
    List<Map<String, dynamic>> entries = await db.query(_tableName);
    return entries.map((e) => MoodEntry.fromMap(e)).toList();
  }
}
