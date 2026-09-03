import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculator/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the calculator to portrait so the layout stays predictable.
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const CalculatorApp());
}
