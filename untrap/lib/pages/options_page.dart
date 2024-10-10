import 'package:flutter/material.dart';
import 'package:untrap/components/color_picker.dart';
import 'package:untrap/components/select_time.dart';
import 'package:untrap/main.dart';
//import 'package:untrap/model/theme.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  OptionsPageState createState() => OptionsPageState();
}

class OptionsPageState extends State<OptionsPage> {
  _changeDate() async {
    await selectDate(context);
    setState(() {});
  }

  _changeTime() async {
    await selectTime(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Options",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.calendar_month_rounded),
            title: const Text("Change Date"),
            trailing: Text(
                "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"),
            onTap: () => _changeDate(),
          ),
          ListTile(
            leading: const Icon(Icons.timelapse_outlined),
            title: const Text("Change Time"),
            trailing: Text(
                "${selectedDate.hour}:${selectedDate.minute.toString().padLeft(2, '0')}"),
            onTap: () => _changeTime(),
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text("Reset Time"),
            onTap: () {
              resetTime();
              setState(() {});
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text("Change Primary Color"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ColorPicker();
                },
              );
            },
          ),
          ListTile(
            leading: MyApp.of(context)?.mode == Brightness.dark
                ? const Icon(Icons.light_mode_sharp)
                : const Icon(Icons.dark_mode),
            title: MyApp.of(context)?.mode == Brightness.dark
                ? const Text("Light Mode")
                : const Text("Dark Mode"),
            onTap: () {
              MyApp.of(context)?.toggleMode();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
