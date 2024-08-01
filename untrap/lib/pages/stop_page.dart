import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untrap/auxiliaries/fetch_times.dart';
import 'package:untrap/components/select_time.dart';
import 'package:untrap/model/stop.dart';

class StopPage extends StatefulWidget {
  final Stop stop;

  const StopPage({super.key, required this.stop});

  @override
  _StopPageState createState() => _StopPageState();
}

class _StopPageState extends State<StopPage> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
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
          widget.stop.code,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
        child: FutureBuilder(
            future: fetchUpcoming(widget.stop.code),
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
            }
          ),
      ),
    );
  }
}