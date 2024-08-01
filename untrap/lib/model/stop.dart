import 'package:flutter/material.dart';
import 'package:untrap/pages/stop_page.dart';

class Stop extends StatelessWidget {
  const Stop(
      {super.key, 
      required this.code,
      required this.name,
      required this.zone,
      this.lat = 0.0,
      this.lon = 0.0});

  final String code;
  final String name;
  final String zone;
  final double lat;
  final double lon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: ListTile(
          dense: true,
          leading: Text(
            code, 
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
          title: Text(name,),
          trailing: Text(zone,),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StopPage(
                  stop: this
                ),
              ),
            );
          }),
    );
  }
}
