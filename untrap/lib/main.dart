import 'package:flutter/material.dart';
import 'package:untrap/auxiliaries/database.dart';
import 'package:untrap/components/map.dart';
import 'package:untrap/components/navigation_bar.dart';
import 'package:untrap/pages/lines.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDatabase();
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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
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
        const MapScreen(),
        const Lines(),
      ][currentPage],
    );
  }
}
