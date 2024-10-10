import 'package:flutter/material.dart';
import 'package:untrap/auxiliaries/fetch_lines.dart';
import 'package:untrap/model/line.dart';

class Lines extends StatefulWidget {
  const Lines({super.key});

  @override
  LinesState createState() => LinesState();
}

class LinesState extends State<Lines> {
  List<Line> filteredLines = [];

  @override
  void initState() {
    super.initState();
    filteredLines = lines;
  }

  void getSuggestionsBasedOnQuery(String query) {
    String lowerCaseQuery = query.toLowerCase();
    filteredLines = lines
        .where((item) =>
            item.name.toLowerCase().contains(lowerCaseQuery) ||
            item.orig.toLowerCase().contains(lowerCaseQuery) ||
            item.dest.toLowerCase().contains(lowerCaseQuery))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
          child: SearchBar(
            leading: const Padding(
                padding: EdgeInsets.only(left: 8.0), child: Icon(Icons.search)),
            hintText: 'Search',
            onChanged: (value) => getSuggestionsBasedOnQuery(value),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredLines.length,
            itemBuilder: (BuildContext context, int index) {
              return filteredLines[index];
            },
          ),
        )
      ],
    );
  }
}
