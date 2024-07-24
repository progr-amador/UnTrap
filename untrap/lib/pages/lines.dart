import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untrap/auxiliaries/fetch_lines.dart';
import 'package:untrap/components/select_time.dart';
import 'package:untrap/model/line.dart';

class Lines extends StatefulWidget {
  const Lines({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LinesState createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  late Timer timer;
  late List<Line> filteredLines;

  @override
  void initState() {
    super.initState();
    _initializeLines();
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      if (selectedDate != DateTime.now() && !changed) {
        setState(() {
          selectedDate = DateTime.now();
        });
      }
    });
    filteredLines = lines;
  }

  @override
  void dispose() {
    lines.clear();
    super.dispose();
  }

  Future<void> _initializeLines() async {
    await fetchLines();
    setState(() {});
  }

  void getSuggestionsBasedOnQuery(String query) {
    String lowerCaseQuery = query.toLowerCase();
    filteredLines = lines
        .where((item) =>
            item.name.toLowerCase().contains(lowerCaseQuery) ||
            item.from.toLowerCase().contains(lowerCaseQuery) ||
            item.to.toLowerCase().contains(lowerCaseQuery))
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
              child: SvgPicture.asset('images/untrap.svg', width: 30,),
            ),
            trailing: <Widget>[
              PopupMenuButton(
                icon: Icon(Icons.access_time,),
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
                  )),
                  PopupMenuItem(
                    onTap: () => resetTime(),
                    child: Text('Reset Time',
                        ),
                  ),
                ],
              ),
            ],
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
