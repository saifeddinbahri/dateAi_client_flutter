import 'package:date_ai/screens/app_shell.dart';
import 'package:date_ai/screens/landing_screen/landing_screen.dart';
import 'package:date_ai/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
class AuthWrapper extends StatelessWidget {
  AuthWrapper({super.key});
  final _secureStorage = SecureStorageService();

  Future<bool> _isLoggedIn() async {
    final token = await _secureStorage.readData('token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,
              body: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }
          if (snapshot.hasData && snapshot.data == true) {
            return const AppShell();
          }
          return const LandingScreen();
        },
    );
  }
}
