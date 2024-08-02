import 'package:flutter/material.dart';
import 'package:untrap/auxiliaries/fetch_times.dart';
import 'package:untrap/model/stop.dart';

class BusScheduleModal extends StatelessWidget {
  final Stop stop;
  const BusScheduleModal({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stop.name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${stop.code} | ${stop.zone}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: fetchUpcoming(stop.code),
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
        ),
      ],
    );
  }
}
