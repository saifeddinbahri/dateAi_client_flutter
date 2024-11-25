import 'package:date_ai/auth_wrapper.dart';
import 'package:date_ai/providers/drawer_provider.dart';
import 'package:date_ai/screens/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DrawerControllerProvider()),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DateAi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
           // seedColor: const Color(0xFFaa8805)
            seedColor: const Color(0xFF032F30)
        ),
        useMaterial3: true,
      ),
      home: AuthWrapper(),
    );
  }
}

