import 'dart:ui';
import 'package:flutter/material.dart';

MaterialColor primaryColor = Colors.blue;
Brightness mode = PlatformDispatcher.instance.platformBrightness;

ThemeData customTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: mode,
  ),
  brightness: mode,
);
