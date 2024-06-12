import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'profile_model.dart';

class DatabaseProfile {
  static final DatabaseProfile _instance = DatabaseProfile._internal();
  static Database? _database;

  factory DatabaseProfile() {
    return _instance;
  }

  DatabaseProfile._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'profile_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE profile(id INTEGER PRIMARY KEY, name TEXT, email TEXT, country TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertOrUpdateProfile(Profile profile) async {
    final db = await database;
    if (profile.id == null) {
      await db.insert(
        'profile',
        profile.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      await db.update(
        'profile',
        profile.toMap(),
        where: 'id = ?',
        whereArgs: [profile.id],
      );
    }
  }

  Future<Profile?> getProfile() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('profile');
    if (maps.isNotEmpty) {
      return Profile(
        id: maps[0]['id'],
        name: maps[0]['name'],
        email: maps[0]['email'],
        country: maps[0]['country'],
      );
    }
    return null;
  }
}
