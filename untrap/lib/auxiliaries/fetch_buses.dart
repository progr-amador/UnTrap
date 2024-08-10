import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:untrap/model/bus.dart';

Future<List<Bus>> fetchBuses() async {
  final response = await http.get(Uri.parse(
      'https://broker.fiware.urbanplatform.portodigital.pt/v2/entities?q=vehicleType==bus&limit=1000'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((bus) => Bus.fromJson(bus)).toList();
  } else {
    throw Exception('Failed to load buses');
  }
}

Future<List<Marker>> generateBusMarkers() async {
  List<Bus> buses = await fetchBuses();
  List<Marker> markers = [];

  for (Bus bus in buses) {
    markers.add(
      Marker(
        point: LatLng(bus.lat, bus.lon),
        width: 30.0,
        height: 30.0,
        rotate: true,
        child: const Icon(
          Icons.bus_alert,
          color: Colors.blue,
        ),
      ),
    );
  }
  return markers;
}
