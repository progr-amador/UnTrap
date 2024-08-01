import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untrap/auxiliaries/fetch_lines.dart';
import 'package:untrap/pages/line_page.dart';
import 'package:hexcolor/hexcolor.dart';

class StopTime extends StatelessWidget {
  const StopTime(
      {super.key,
      required this.stopID,
      required this.lineName,
      required this.direction,
      required this.weekday,
      required this.shift,
      required this.time,
      required this.operator,
      required this.color});

  final String stopID;
  final String lineName;
  final int direction;
  final String weekday;
  final int shift;
  final String time;
  final String operator;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: ListTile(
        dense: true,
        leading: SizedBox(
          width: 35,
          child: SvgPicture.asset(
            'images/$operator.svg',
            color: HexColor('#$color'),
          ),
        ),
        title: Text(lineName,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        trailing: 
            Text(
              time,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
        
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LinePage(line: lines.firstWhere((line) => line.name == lineName)),
            )
          );
        }
      ),
    );
  }
}
