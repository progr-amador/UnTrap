import 'package:flutter/material.dart';
import 'package:untrap/main.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.circle_rounded, color: Colors.blue,),
                title: const Text("Blue"),
                onTap: () {
                  MyApp.of(context)?.changeColor(Colors.blue);
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.circle_rounded, color: Colors.red,),
                title: const Text("Red"),
                onTap: () {
                  MyApp.of(context)?.changeColor(Colors.red);
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.circle_rounded, color: Colors.green,),
                title: const Text("Green"),
                onTap: () {
                  MyApp.of(context)?.changeColor(Colors.green);
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.circle_rounded, color: Colors.yellow,),
                title: const Text("Yellow"),
                onTap: () {
                  MyApp.of(context)?.changeColor(Colors.yellow);
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.circle_rounded, color: Colors.orange,),
                title: const Text("Orange"),
                onTap: () {
                  MyApp.of(context)?.changeColor(Colors.orange);
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.circle_rounded, color: Colors.purple,),
                title: const Text("Purple"),
                onTap: () {
                  MyApp.of(context)?.changeColor(Colors.purple);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
