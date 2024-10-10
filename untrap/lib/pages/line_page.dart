import 'package:flutter/material.dart';
import 'package:untrap/auxiliaries/fetch_stops.dart';
import 'package:untrap/components/select_time.dart';
import 'package:untrap/model/line.dart';

class LinePage extends StatefulWidget {
  final Line line;
  const LinePage({super.key, required this.line});

  @override
  LinePageState createState() => LinePageState();
}

class LinePageState extends State<LinePage> {
  String day = 'S';
  String eday = 'I';
  int direction = 1;

  @override
  void initState() {
    super.initState();
    switch (selectedDate.weekday) {
      case DateTime.saturday:
        day = 'S';
        eday = 'I';
      case DateTime.sunday:
        day = 'D';
        eday = 'J';
      default:
        day = 'U';
        eday = 'K';
    }
  }

  void _swapOrigDest() {
    setState(() {
      direction == 1 ? direction = 0 : direction = 1;
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
      body: Column(
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
              direction == 1 ? widget.line.orig : widget.line.dest,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              direction == 1 ? widget.line.dest : widget.line.orig,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future:
                  fetchLineStops(day, eday, widget.line.name, direction + 3),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  var lineStops = snapshot.data!;
                  return ListView.builder(
                      itemCount: lineStops.length,
                      itemBuilder: (BuildContext context, int index) {
                        return lineStops[index];
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
