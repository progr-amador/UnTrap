import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:untrap/auxiliaries/database.dart';
import 'package:untrap/auxiliaries/fetch_lines.dart';
import 'package:untrap/components/navigation_bar.dart';
//import 'package:untrap/model/theme.dart';
import 'package:untrap/pages/lines.dart';
import 'package:untrap/pages/map_page.dart';
import 'package:untrap/pages/options_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  await fetchLines();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();

  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  MaterialColor primaryColor = Colors.blue;
  Brightness mode = PlatformDispatcher.instance.platformBrightness;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UnTrap',
      theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: mode,
      ),
      brightness: mode,
    ),
      home: const MyHomePage(),
    );
  }

  void changeColor(MaterialColor color) {
    setState(() {
      primaryColor = color;
    });
  }

  void toggleMode() {
    setState(() {
      mode = mode == Brightness.dark ? Brightness.light : Brightness.dark;
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _changePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: BottomBar(
        changePage: _changePage,
      ),
      body: [
        const MapPage(),
        const Lines(),
        const OptionsPage(),
      ][currentPage],
    );
  }
}
