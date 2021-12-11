import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;

  static const int _version = 1;

  static const _tabelName = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'tasks.db';
        _db = (await openDatabase(
          _path,
          version: _version,
          onCreate: (db, version) {
            return db.execute(
              "CREATE TABLE $_tabelName ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title STRING, note TEXT, date STRING, "
              "startTime STRING, endTime STRING, "
              "remind INTEGER, repeat INTEGER, "
              "color INTEGER, "
              "isCompleted INTEGER)",
            );
          },
        ));
      } catch (e) {
        // ignore: avoid_print
        print("ERROR: $e");
      }
    }
  }

  static Future<int> inserat({Task? task}) async {
    return await _db!.insert(_tabelName, task!.toJson());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tabelName);
  }

  static delete({required Task task}) async {
    return await _db!.delete(_tabelName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
    UPDATE tasks 
    SET isCompleted = ? 
    WHERE id = ?
    ''', [1, id]);
  }
}
