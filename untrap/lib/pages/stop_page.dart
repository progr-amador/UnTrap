import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untrap/auxiliaries/fetch_times.dart';
import 'package:untrap/components/select_time.dart';
import 'package:untrap/model/stop.dart';
import 'package:untrap/model/stop_time.dart';

class StopPage extends StatefulWidget {
  final Stop stop;

  const StopPage({super.key, required this.stop});

  @override
  StopPageState createState() => StopPageState();
}

class StopPageState extends State<StopPage> {
  late Timer timer;
  late Future<List<StopTime>> upcoming;

  @override
  void initState() {
    super.initState();
    upcoming = fetchUpcoming(widget.stop.code);
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      if (!changed) selectedDate = DateTime.now();
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.stop.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
          future: upcoming,
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var buses = snapshot.data!;
              return ListView.builder(
                itemCount: buses.length,
                itemBuilder: (BuildContext context, int index) {
                  return buses[index];
                },
              );
            }
          }),
    );
  }
}
