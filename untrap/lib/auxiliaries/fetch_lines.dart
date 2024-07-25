import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:untrap/model/line.dart';

List<Line> lines = [];

Future<void> fetchLines() async {
  final input = await rootBundle.loadString('files/lines.csv');
  final data = const CsvToListConverter().convert(input);

  for (var row in data) {
    lines.add(
      Line(
          operator: row[0].toString(),
          name: row[1].toString(),
          from: row[2].toString(),
          to: row[3].toString(),
          color: row[4].toString().toLowerCase()),
    );
  }
}
