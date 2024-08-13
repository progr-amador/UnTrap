import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:untrap/components/map.dart';
import 'package:untrap/components/search_bar_stops.dart';

StreamController<double?> alignPositionStreamController =
    StreamController<double?>();
AlignOnUpdate alignPositionOnUpdate = AlignOnUpdate.never;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
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
        const NavigationMap(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton(
              onPressed: () {
                setState(
                  () => alignPositionOnUpdate = AlignOnUpdate.always,
                );
                alignPositionStreamController.add(19);
              },
              child: const Icon(
                Icons.my_location,
              ),
            ),
          ),
        ),
        SearchBarStops(refresh: _refresh),
      ],
    );
  }
}
