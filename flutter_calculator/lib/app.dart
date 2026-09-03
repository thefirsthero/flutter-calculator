import 'package:flutter/material.dart';
import 'package:flutter_calculator/controller/calculate_controller.dart';
import 'package:flutter_calculator/controller/theme_controller.dart';
import 'package:flutter_calculator/screens/calculator_screen.dart';
import 'package:flutter_calculator/theme/app_theme.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final CalculateController _calculator = CalculateController();
  final ThemeController _theme = ThemeController();

  @override
  void dispose() {
    _calculator.dispose();
    _theme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[_calculator, _theme]),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Calculator',
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: _theme.mode,
          home: CalculatorScreen(calculator: _calculator, theme: _theme),
        );
      },
    );
  }
}
