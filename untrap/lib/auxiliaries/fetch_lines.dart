import 'package:untrap/auxiliaries/database.dart';
import 'package:untrap/model/line.dart';

List<Line> lines = [];

Future<void> fetchLines() async {
  List<Map> query = await database.rawQuery('SELECT * FROM LINE');

  for (Map line in query) {
    lines.add(
      Line(
          operator: line["lineOperator"],
          name: line["lineName"],
          orig: line["lineOrig"],
          dest: line["lineDest"],
          color: line["lineColor"]),
    );
  }
}

Line getLine(String lineName) {
  Map line =
      database.rawQuery("SELECT * FROM LINE WHERE lineName = '$lineName'");

  return Line(
      operator: line["lineOperator"],
      name: line["lineName"],
      orig: line["lineOrig"],
      dest: line["lineDest"],
      color: line["lineColor"]);
}
