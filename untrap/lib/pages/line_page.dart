import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:untrap/components/select_time.dart';
import 'package:untrap/model/line.dart';
import 'stop_page.dart';

// ignore: must_be_immutable
class LinePage extends StatefulWidget {
  final Line line;
  bool direction = true;

  LinePage({super.key, required this.line});

  @override
  _LinePageState createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  Future<List<String>> data(String line, bool direction) async {
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

  void _swapOrigDest() {
    setState(() {
      widget.direction = !widget.direction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.line.name,
          style: const TextStyle(
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
                icon: const Icon(
                  Icons.multiple_stop,
                  size: 40,
                ),
                onPressed: _swapOrigDest,
              ),
              title: Text(
                widget.direction ? widget.line.orig : widget.line.dest,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
              subtitle: Text(
                widget.direction ? widget.line.dest : widget.line.orig,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: data(widget.line.name, widget.direction),
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
                            stop,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          trailing: Text(
                            stop,
                            style: const TextStyle(
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
