import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untrap/components/select_time.dart';
import 'package:untrap/auxiliaries/fetch_stops.dart';
import 'stop_page.dart';

// ignore: must_be_immutable
class LinePage extends StatefulWidget {
  final String line;
  String orig;
  String dest;
  int direction = 0;

  LinePage({Key? key, required this.line, required this.orig, required this.dest});

  @override
  _LinePageState createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {

  Future<List<String>> data(String line, int direction) async {
    String jsonString = await rootBundle.loadString('files/stop_times.json');
    List<dynamic> data = json.decode(jsonString);

    String day = 'U';
    if (line == "E1" || line == "E18") day = 'I';

    List<String> stopsList = [];
    data.forEach((stop) {
      if (stop["t"] == "${line}_${direction}_${day}_1") {
        stopsList.add(stop["s"]);
      }
    });
    if (stopsList.isEmpty) {
      data.forEach((stop) {
        if (stop["t"] == "${line}_${direction}_${day}_2") {
          stopsList.add(stop["s"]);
        }
      });
    }

    return stopsList;
  }

  String stopName(String code) {
    if (stops.containsKey(code)) {
      return stops[code]!;
    }
    return "NULL";
  }

  void _swapOrigDest() {
    setState(() {
      String temp = widget.orig;
      widget.orig = widget.dest;
      widget.dest = temp;
      if (widget.direction == 1) {
        widget.direction = 0;
      } else {
        widget.direction = 1;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Theme.of(context).focusColor),
        title: Text(
          widget.line,
          style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.rightLeft,
                  color: Theme.of(context).focusColor,
                ),
                onPressed: _swapOrigDest,
              ),
              title: Text(
                widget.orig,
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: 13,
                ),
              ),
              subtitle: Text(
                widget.dest,
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: data(widget.line, widget.direction),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<String> stopsList = snapshot.data!;
                    return ListView.builder(
                      itemCount: stopsList.length,
                      itemBuilder: (context, index) {
                        String stop = stopsList[index];
                        return ListTile(
                          title: Text(
                            stopName(stop),
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          trailing: Text(
                            stop,
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          onTap: () {
                            if (!changed) selectedDate = DateTime.now();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StopPage(
                                  stopId: stop,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
