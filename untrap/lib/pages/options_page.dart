import 'package:flutter/material.dart';
import 'package:untrap/components/select_time.dart';
import 'package:untrap/model/theme.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {

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
            trailing: Text("${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"),
            onTap: () => selectDate(context),
          ),
          ListTile(
            leading: const Icon(Icons.timelapse_outlined),
            title: const Text("Change Time"),
            trailing: Text("${selectedDate.hour}:${selectedDate.minute.toString().padLeft(2, '0')}"),
            onTap: () => selectTime(context),
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text("Reset Time"),
            onTap: () => resetTime(),
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text("Change Primary Color"),
            //onTap: () => resetTime(),
          ),
          ListTile(
            leading: mode == Brightness.dark? const Icon(Icons.light_mode_sharp) : const Icon(Icons.dark_mode),
            title: mode == Brightness.dark? const Text("Light Mode") : const Text("Dark Mode"),
            //onTap: () => resetTime(),
          ),
        ],
      ),
    );
  }
}
