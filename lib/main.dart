import 'package:date_ai/screens/bottom_nav.dart';
import 'package:date_ai/screens/home_screen/home_screen.dart';
import 'package:date_ai/screens/landing_screen/landing_screen.dart';
import 'package:date_ai/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFaa8805)
        ),
        useMaterial3: true,
      ),
      home: const BottomNav(),
    );
  }
}

