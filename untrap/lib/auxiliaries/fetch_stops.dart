import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:untrap/auxiliaries/database.dart';
import 'package:untrap/model/stop.dart';
import 'package:untrap/components/bottom_sheet.dart';

List<Stop> stops = [];

Future<void> fetchStops() async {
  List<Map> query = await database.rawQuery('SELECT * FROM STOP');

  for (Map stop in query) {
    stops.add(
      Stop(
          code: stop["stopID"],
          name: stop["stopName"],
          zone: stop["stopZone"],
          lat: stop["stopLat"],
          lon: stop["stopLon"]),
    );
  }
}

Future<List<Stop>> fetchLineStops(
    String weekday, String lineName, int shift) async {
  List<Stop> lineStops = [];
  List<Map> query = await database.rawQuery(
      "SELECT stopName, stopID, stopZone FROM STOP JOIN STOP_TIME USING(stopID) WHERE weekday = '$weekday' AND lineName = '$lineName' AND shift = $shift ORDER BY time");

  for (Map stop in query) {
    lineStops.add(
      Stop(
        code: stop["stopID"],
        name: stop["stopName"],
        zone: stop["stopZone"],
      ),
    );
  }

  return lineStops;
}

Future<List<Marker>> generateStopMarkers(BuildContext context) async {
  await fetchStops();
  List<Marker> markers = [];

  for (Stop stop in stops) {
    markers.add(
      Marker(
        point: LatLng(stop.lat, stop.lon),
        width: 30.0,
        height: 30.0,
        rotate: true,
        child: IconButton(
          icon: (stop.code[0] == "5" && stop.code.length == 4)
              ? const Icon(Icons.directions_subway)
              : const Icon(Icons.directions_bus),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Theme.of(context).dialogBackgroundColor,
              context: context,
              builder: (BuildContext context) {
                return BusScheduleModal(
                  stop: stop,
                );
              },
            );
          },
        ),
      ),
    );
  }
  return markers;
}
