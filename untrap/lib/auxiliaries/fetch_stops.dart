import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:untrap/model/stop.dart';
import 'package:untrap/components/bottom_sheet.dart';
import 'package:untrap/components/map.dart';

List<Stop> stops = [];

Future<void> fetchStops() async {
  final input = await rootBundle.loadString('files/stops.csv');
  final data = const CsvToListConverter().convert(input);

  for (var row in data) {
    stops.add(
      Stop(code: row[0], name: row[1], zone: row[2], lat: row[3], lon: row[4]),
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
