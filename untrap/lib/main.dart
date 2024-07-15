import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:untrap/components/map.dart';
import 'package:untrap/components/navigation_bar.dart';
import 'pages/lines.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLight = (PlatformDispatcher.instance.platformBrightness == Brightness.light);

  bool isThemeLight() {
    return isLight;
  }

  void toggleTheme() {
    setState(() {
      isLight = !isLight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UnTrap',
      theme: ThemeData(
          highlightColor: const Color.fromARGB(255, 218, 71, 49),
          primaryColor: Colors.white,
          hintColor: const Color.fromRGBO(242, 243, 243, 1.0),
          fontFamily: 'CenturyGothic',
          focusColor: Colors.black),
      darkTheme: ThemeData(
          highlightColor: const Color.fromARGB(255, 218, 71, 49),
          primaryColor: const Color.fromRGBO(26, 26, 27, 1.0),
          hintColor: const Color.fromRGBO(42, 42, 43, 1.0),
          fontFamily: 'CenturyGothic',
          focusColor: Colors.white),
      themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
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

  void _changePage(int index){
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: scaffoldKey,
      bottomNavigationBar: BottomBar(changePage: _changePage,),
      body: [
        const MapScreen(),
        const Lines(),
      ][currentPage],
    );
  }
}
