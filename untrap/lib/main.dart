import 'package:flutter/material.dart';
import 'package:untrap/auxiliaries/database.dart';
import 'package:untrap/auxiliaries/fetch_lines.dart';
import 'package:untrap/components/navigation_bar.dart';
import 'package:untrap/model/theme.dart';
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
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UnTrap',
      theme: customTheme,
      home: const MyHomePage(),
    );
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
