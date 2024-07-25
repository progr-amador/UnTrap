import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:untrap/auxiliaries/fetch_times.dart';
import 'package:untrap/components/select_time.dart';
import 'dart:async';

import 'package:untrap/model/stop.dart';


class BusScheduleModal extends StatefulWidget {
  final Stop stop;
  const BusScheduleModal({super.key, required this.stop});

  @override
  __BusScheduleModalState createState() => __BusScheduleModalState();
}

class __BusScheduleModalState extends State<BusScheduleModal> {
  late Future<List<Map<String, dynamic>>> busSchedule;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    busSchedule = getBusSchedule(widget.stop.code);
    if (!changed) selectedDate = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) {
      setState(() {
        if (!changed) selectedDate = DateTime.now();
        busSchedule = getBusSchedule(widget.stop.code);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: busSchedule,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<dynamic> buses = snapshot.data as List<dynamic>;
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
                          widget.stop.name,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.stop.code} | ${widget.stop.zone}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: buses.length,
                  itemBuilder: (context, index) {
                    var bus = buses[index];
                    DateTime scheduledArrivalTime =
                    _parseTimeString(bus["departure"]);
                    String formattedArrivalTime =
                    DateFormat('HH:mm').format(scheduledArrivalTime);

                    Duration remainingTime =
                    scheduledArrivalTime.difference(selectedDate);

                    if (remainingTime.inMinutes < 120) {
                      String remainingText = remainingTime.inMinutes == 0
                          ? 'Passing'
                          : '${remainingTime.inMinutes} min';
                      String toAppear =
                      (remainingTime.inMinutes < 60 && !changed)
                          ? remainingText
                          : formattedArrivalTime;
                      return ListTile(
                        leading: SizedBox(
                          width: 30,
                          child: SvgPicture.asset(
                            'images/stcp.svg',
                            width: 30,
                          ),
                        ),
                        title: Text(
                          bus["bus_number"],
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          toAppear,
                          style: const TextStyle(
                              fontSize: 15),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  DateTime _parseTimeString(String timeString) {
    List<String> parts = timeString.split(':');
    return DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
        int.parse(parts[0]), int.parse(parts[1]));
  }
  
}