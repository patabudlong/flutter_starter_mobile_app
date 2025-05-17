import 'package:flutter/material.dart';
import 'package:flutter_starter_mobile_app/config/theme.dart';
import 'package:flutter_starter_mobile_app/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Starter App',
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
