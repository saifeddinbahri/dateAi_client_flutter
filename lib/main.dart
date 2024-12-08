import 'package:date_ai/auth_wrapper.dart';
import 'package:date_ai/providers/drawer_provider.dart';
import 'package:date_ai/screens/anomaly_description_screen/anomaly_description_screen.dart';
import 'package:date_ai/screens/app_shell.dart';
import 'package:date_ai/screens/treatment_preview_screen/treatment_preview_screen.dart';
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
      /*const TreatmentPreviewScreen(
        title: 'Oct 24, 2024',
        disease: 'Disease',
        image: 'https://img.freepik.com/free-photo/leaves-tropical-palm_23-2147829135.jpg?t=st=1731345775~exp=1731349375~hmac=70a6d94c6014fded77ac71ba3ca8a846d3b1544a5d5ddff6aee977599f38568d&w=996',
      ),*/

      /*const AnomalyDescriptionScreen(
          imageURL: 'https://img.freepik.com/free-photo/leaves-tropical-palm_23-2147829135.jpg?t=st=1731345775~exp=1731349375~hmac=70a6d94c6014fded77ac71ba3ca8a846d3b1544a5d5ddff6aee977599f38568d&w=996',
          title: 'mradh mel amradh'),*/
    );
  }
}

