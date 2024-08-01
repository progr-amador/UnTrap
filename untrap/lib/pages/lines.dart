import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untrap/auxiliaries/fetch_lines.dart';
import 'package:untrap/model/line.dart';

class Lines extends StatefulWidget {
  const Lines({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LinesState createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  List<Line> filteredLines = lines;

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
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                'images/untrap.svg',
                width: 30,
              ),
            ),
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
        ),
      ],
    );
  }
}
