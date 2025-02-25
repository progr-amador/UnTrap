import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untrap/pages/line_page.dart';
import 'package:hexcolor/hexcolor.dart';


class Line extends StatelessWidget {
  const Line(
      {super.key,
      required this.operator,
      required this.name,
      required this.orig,
      required this.dest,
      required this.color});

  final String operator;
  final String name;
  final String orig;
  final String dest;
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
          title: Text(name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                orig,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                dest,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LinePage(
                  line: this
                ),
              ),
            );
          }),
    );
  }
}
