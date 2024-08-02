import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:untrap/auxiliaries/fetch_stops.dart';
import 'package:untrap/model/stop.dart';
import 'package:untrap/components/map.dart';
import 'package:untrap/components/select_time.dart';


class SearchBarStops extends StatefulWidget {
  const SearchBarStops({super.key, required this.refresh});

  final void Function() refresh;

  @override
  SearchBarStopsState createState() => SearchBarStopsState();
}

class SearchBarStopsState extends State<SearchBarStops> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      if (selectedDate != DateTime.now() && !changed) {
        setState(() {
          selectedDate = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List<Stop> filteredSuggestions = [];

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
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset('images/untrap.svg', width: 30,),
              ),
              trailing: <Widget>[
                PopupMenuButton(
                  icon: const Icon(Icons.access_time),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () => selectDate(context),
                      child: Text(
                        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => selectTime(context),
                      child: Text(
                        '${selectedDate.hour}:${selectedDate.minute.toString().padLeft(2, '0')}',
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => resetTime(),
                      child: const Text(
                        'Reset Time',
                      ),
                    ),
                  ],
                ),
              ],
              hintText: 'Search',
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
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
