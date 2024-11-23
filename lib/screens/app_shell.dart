import 'package:date_ai/screens/camera_screen/camera_screen.dart';
import 'package:date_ai/screens/home_screen/home_screen.dart';
import 'package:date_ai/screens/landing_screen/landing_screen.dart';
import 'package:date_ai/services/secure_storage_service.dart';
import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drawer_provider.dart';
import 'history_screen/history_screen.dart';


class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  List<dynamic> _pages = [] ;
  int _activeIndex = 0;

  void _changeActivePage(int index) {
    setState(() {
      _activeIndex = index;
    });
  }
  void _logout() async {
    final secureStorage = SecureStorageService();
    await secureStorage.deleteData('token');

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        ),
        ModalRoute.withName("/Login")
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      { 'screen': const HomeScreen(), 'padding': true},
      { 'screen': const CameraScreen(), 'padding': false},
      { 'screen': const HistoryScreen(), 'padding': true},
    ];
  }


  @override
  Widget build(BuildContext context) {
    final drawerController = Provider.of<DrawerControllerProvider>(context);
    final screenSize = ScreenSize(context);
    final theme = ThemeHelper(context);

    return Scaffold(
        key: drawerController.scaffoldKey,
        backgroundColor: const Color(0xFFf8f8f6),  //const Color(0xFFF8F5F2),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Eya',
                      textAlign: TextAlign.start,
                      style: theme.textStyle.titleLarge,
                    ),
                    SizedBox(height: screenSize.height * 0.01,),
                    Text(
                      'eya78@gmail.com',
                      textAlign: TextAlign.start,
                      style: theme.textStyle.titleMedium,
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: _logout,
                title: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                    SizedBox(width: screenSize.width * 0.02,),
                    Text(
                      'Log out',
                      style: theme.textStyle.titleMedium,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () => _changeActivePage(0),
                  icon: Icon(
                    Icons.home,
                    color:  _activeIndex == 0 ? Colors.white : Colors.white70 ,
                  ),
              ),
              IconButton(onPressed: () => _changeActivePage(1),
                  icon: Icon(Icons.camera_alt,
                    color: _activeIndex == 1 ? Colors.white : Colors.white70,)
              ),
              IconButton(onPressed: () => _changeActivePage(2),
                  icon: Icon(Icons.history,
                    color: _activeIndex == 2 ? Colors.white : Colors.white70,)
              ),
            ],
          ),
        ),
        body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _screenPadding(
                _pages[_activeIndex]['screen'],
                _pages[_activeIndex]['padding']),
        ),
    );
  }

  Widget _screenPadding(Widget screen, bool setPadding) {
    final screenPadding = ScreenPadding(context);
    final screenSize = ScreenSize(context);

    if (setPadding) {
      return Padding(
        padding: EdgeInsets.only(
            right: screenPadding.horizontal,
            left: screenPadding.horizontal,
            top: screenSize.height * 0.05),
        child: screen,
      );
    }
    return screen;
  }
}
