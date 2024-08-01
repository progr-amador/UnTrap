import 'package:untrap/auxiliaries/database.dart';
import 'package:untrap/components/select_time.dart';
import 'package:untrap/model/stop_time.dart';

Future<List<StopTime>> fetchUpcoming(String stopID) async {
  List<StopTime> stopTimes = [];
  DateTime generousDate = selectedDate.subtract(const Duration(minutes: 5));
  String day;
  String time =
      "${generousDate.hour}:${generousDate.minute}:${generousDate.second}";

  switch (generousDate.weekday) {
    case DateTime.saturday:
      day = 'S';
    case DateTime.sunday:
      day = 'D';
    default:
      day = 'U';
  }

  String query =
      "SELECT stopID, lineName, direction, weekday, shift, time, lineOperator, lineColor FROM STOP_TIME JOIN LINE USING(lineName) WHERE stopID = '$stopID' AND time > '$time' AND weekday = '$day' ORDER BY time ASC LIMIT 10;";

  List<Map> result = await database.rawQuery(query);

  print(result.length);

  for (Map entry in result) {
    stopTimes.add(
      StopTime(
          stopID: entry["stopID"],
          lineName: entry["lineName"],
          direction: entry["direction"],
          weekday: entry["weekday"],
          shift: entry["shift"],
          time: entry["time"],
          operator: entry["lineOperator"],
          color: entry["lineColor"]),
    );
  }

  return stopTimes;
}
