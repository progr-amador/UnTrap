import 'package:untrap/auxiliaries/database.dart';
import 'package:untrap/components/select_time.dart';
import 'package:untrap/model/stop_time.dart';

Future<List<StopTime>> fetchUpcoming(String stopID) async {
  List<StopTime> stopTimes = [];
  DateTime generousDate = selectedDate.subtract(const Duration(minutes: 5));
  String day;
  String time = generousDate.hour < 10 ? 
    "0${generousDate.hour}:${generousDate.minute}:${generousDate.second}":
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
      "SELECT stopID, lineName, tripDest, direction, weekday, shift, time, lineOperator, lineColor FROM STOP_TIME JOIN LINE USING(lineName) JOIN TRIP USING(tripID) WHERE stopID = '$stopID' AND time > '$time' AND weekday = '$day' ORDER BY time ASC LIMIT 10";
  List<Map> result = await database.rawQuery(query);

  for (Map entry in result) {
    String hour = entry["time"].split(':')[0];
    String minute = entry["time"].split(':')[1];
    stopTimes.add(
      StopTime(
          stopID: entry["stopID"],
          lineName: entry["lineName"],
          tripDest: entry["tripDest"],
          direction: entry["direction"],
          weekday: entry["weekday"],
          shift: entry["shift"],
          time: "$hour:$minute",
          operator: entry["lineOperator"],
          color: entry["lineColor"]),
    );
  }

  return stopTimes;
}
