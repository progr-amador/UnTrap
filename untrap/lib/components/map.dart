import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:untrap/auxiliaries/fetch_stops.dart';
//import 'package:untrap/auxiliaries/fetch_buses.dart';

LatLng mapPosition = const LatLng(41.1579, -8.6291);
double mapZoom = 13.0;
double mapRotation = 0;
MapController mapController = MapController();
StreamController<double?> alignPositionStreamController =
    StreamController<double?>();
AlignOnUpdate alignPositionOnUpdate = AlignOnUpdate.never;

class NavigationMap extends StatefulWidget {
  const NavigationMap({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationMapState createState() => _NavigationMapState();
}

class _NavigationMapState extends State<NavigationMap> {
  late Future<List<Marker>> stopMarkers;
  //late Future<List<Marker>> busMarkers;

  @override
  void initState() {
    super.initState();
    stopMarkers = generateStopMarkers(context);
    //busMarkers = generateBusMarkers();
    _initializeLocator();
    setState(() {});
  }

  @override
  void dispose() {
    alignPositionStreamController.close();
    super.dispose();
  }

  Future<void> _initializeLocator() async {
    setState(() {
      alignPositionStreamController = StreamController<double?>();
    });
  }

  void _refresh() {
    setState(
      () => alignPositionOnUpdate = AlignOnUpdate.never,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
            future: stopMarkers, //Future.wait([stopMarkers, busMarkers]),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                var stops = snapshot.data!;
                //var buses = snapshot.data![1];
                return FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: mapPosition, // Porto coordinates
                    initialZoom: mapZoom,
                    initialRotation: mapRotation,
                    maxZoom: 20.0,
                    minZoom: 11,
                    keepAlive: true,
                    cameraConstraint: CameraConstraint.contain(
                      bounds: LatLngBounds(
                        const LatLng(41.013498, -8.767652), // southwest
                        const LatLng(41.283688, -8.347762), // northeast
                      ),
                    ),
                    onPositionChanged: (position, hasGesture) {
                      mapZoom = mapController.camera.zoom;
                      mapPosition = mapController.camera.center;
                      mapRotation = mapController.camera.rotation;
                      if (hasGesture) {
                        setState(
                          () => alignPositionOnUpdate = AlignOnUpdate.never,
                        );
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: Theme.of(context).brightness ==
                              Brightness.light
                          ? 'http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png'
                          : 'http://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
                      tileBounds: LatLngBounds(
                        const LatLng(41.013498, -8.767652), // southwest
                        const LatLng(41.283688, -8.347762), // northeast
                      ),
                    ),
                    MarkerClusterLayerWidget(
                      options: MarkerClusterLayerOptions(
                        maxClusterRadius: 15,
                        size: const Size(0, 0),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(30),
                        maxZoom: 15,
                        markers: stops,
                        builder: (context, markers) {
                          return const SizedBox();
                        },
                      ),
                    ),
                    /*MarkerClusterLayerWidget(
                      options: MarkerClusterLayerOptions(
                        maxClusterRadius: 30,
                        size: const Size(0, 0),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(30),
                        maxZoom: 15,
                        markers: buses,
                        builder: (context, markers) {
                          return const SizedBox();
                        },
                      ),
                    ),*/
                    CurrentLocationLayer(
                      alignPositionStream: alignPositionStreamController.stream,
                      alignPositionOnUpdate: alignPositionOnUpdate,
                      style: const LocationMarkerStyle(
                        marker: DefaultLocationMarker(),
                        markerSize: Size(20, 20),
                        markerDirection: MarkerDirection.heading,
                        showAccuracyCircle: false,
                        showHeadingSector: false,
                      ),
                    ),
                  ],
                );
              }
            }),
      ],
    );
  }
}
