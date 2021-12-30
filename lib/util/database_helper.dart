import 'dart:io';
import 'package:flutter/services.dart';
import 'package:cns/models/event.dart';
import 'package:cns/models/eventDTO.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper!;
    } else {
      return _databaseHelper!;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  Future<Database> _initializeDatabase() async {
    var lock = Lock();
    Database? _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, "appDB.db");
          print("DB's path : $path");
          var file = new File(path);

          // check if file exists
          if (!await file.exists()) {
            // Copy from asset
            ByteData data = await rootBundle.load(join("asset", "task.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          // open the database
          _db = await openDatabase(path);
        }
      });
    }

    return _db!;
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    var db = await _getDatabase();
    var result = await db.query("task", orderBy: "time ASC");
    return result;
  }

  Future<List<EventModel>> getTaskList() async {
    List<Map<String, dynamic>> taskMapList = await getTasks();
    List<EventModel> taskList = [];
    for (Map map in taskMapList) {
      taskList.add(EventModel.fromMap(map));
    }
    return taskList;
  }

  Future<int> addTask(EventModel eventModel) async {
    ///TODO: Provide proper ID
    EventDTO eventDTO = EventDTO(
      id: eventModel.id ?? DateTime.now().second,
      time: (eventModel.time!.hour.toString() +
          ':' +
          eventModel.time!.minute.toString()),
      description: eventModel.description,
      title: eventModel.title,
      eventDate: eventModel.eventDate.toString(),
    );

    // eventDTO.time = eventModel.time.toString();

    var db = await _getDatabase();
    var result = await db.insert("task", eventDTO.toMap());

    print(eventDTO.time.toString() + " --- " + eventDTO.eventDate.toString());
    return result;
  }

  Future<int> updateTask(EventModel eventModel) async {
    ///TODO: Provide proper ID
    EventDTO eventDTO = EventDTO(
      id: eventModel.id ?? DateTime.now().second,
      time: (eventModel.time!.hour.toString() +
          ':' +
          eventModel.time!.minute.toString()),
      description: eventModel.description,
      title: eventModel.title,
      eventDate: eventModel.eventDate.toString(),
    );

    var db = await _getDatabase();
    var result = await db.update("task", eventDTO.toMap(),
        where: 'id = ?', whereArgs: [eventModel.id]);
    return result;
  }

  Future<int> deleteTask(int id) async {
    var db = await _getDatabase();
    var result = await db.delete("task", where: 'id = ?', whereArgs: [id]);
    return result;
  }
}
