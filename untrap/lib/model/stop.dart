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
          title: Text(
            name, 
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold
            )
          ),
          subtitle: Opacity(
            opacity: 0.6,
            child: Text(
              code,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              )
            ),
          ),
          trailing: Text(
            zone,
            style: const TextStyle(
              fontSize: 15,
            )
          ),
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
