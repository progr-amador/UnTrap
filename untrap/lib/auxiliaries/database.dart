import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:untrap/auxiliaries/fetch_lines.dart';
import 'package:untrap/auxiliaries/fetch_stops.dart';

var database;

Future<void> initializeDatabase() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "untrap.db");

  // Check if the database exists
  var exists = await databaseExists(path);

  if (!exists) {
    // Should happen only the first time you launch your application
    print("Creating new copy from asset");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(url.join("files", "untrap.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Opening existing database");
  }

  database = await openDatabase(path, readOnly: true);

  fetchLines();
  fetchStops();
}
