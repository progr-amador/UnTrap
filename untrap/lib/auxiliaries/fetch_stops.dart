import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:untrap/auxiliaries/database.dart';
import 'package:untrap/model/stop.dart';
import 'package:untrap/components/bottom_sheet.dart';
import 'package:untrap/components/map.dart';

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

Future<void> generateMarkers(BuildContext context) async {
  for (Stop stop in stops) {
    markers.add(
      Marker(
          point: LatLng(stop.lat, stop.lon),
          width: 30.0,
          height: 30.0,
          rotate: true,
          child: IconButton(
              icon: const Icon(Icons.directions_bus),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return BusScheduleModal(
                      stop: stop,
                    );
                  },
                );
              })),
    );
  }
}
