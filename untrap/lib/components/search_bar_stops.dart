import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:untrap/auxiliaries/fetch_stops.dart';
import 'package:untrap/model/stop.dart';
import 'package:untrap/components/map.dart';

class SearchBarStops extends StatefulWidget {
  const SearchBarStops({super.key, required this.refresh});

  final void Function() refresh;

  @override
  SearchBarStopsState createState() => SearchBarStopsState();
}

class SearchBarStopsState extends State<SearchBarStops> {
  List<Stop> stops = [];
  List<Stop> filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _getStops();
  }

  Future<void> _getStops() async {
    stops = await fetchStops();
  }

  List<Stop> getSuggestionsBasedOnQuery(String query) {
    return stops
        .where((item) =>
            item.code.toLowerCase().contains(query) ||
            item.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
      return Padding(
        padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
        child: SearchBar(
          controller: controller,
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.search),
          ),
          hintText: 'Search',
        ),
      );
    }, suggestionsBuilder: (BuildContext context, SearchController controller) {
      String query = controller.text.toLowerCase();
      filteredSuggestions = getSuggestionsBasedOnQuery(query);

      return List.generate(filteredSuggestions.length, (int index) {
        final Stop item = filteredSuggestions[index];
        return ListTile(
          title: Text(
            "${item.code} - ${item.name}",
          ),
          onTap: () {
            mapController.move(LatLng(item.lat, item.lon), 19.0);
            widget.refresh();
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
        );
      });
    });
  }
}
