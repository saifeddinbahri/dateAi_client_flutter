import 'package:date_ai/screens/camera_screen/camera_screen.dart';
import 'package:date_ai/screens/home_screen/home_screen.dart';
import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';

import 'history_screen/history_screen.dart';
class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<dynamic> _pages = [] ;
  int _activeIndex = 0;


  void changeActivePage(int index) {
    setState(() {
      _activeIndex = index;
    });
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
    final screenPadding = ScreenPadding(context);
    final screenSize = ScreenSize(context);
    final theme = ThemeHelper(context);

    return Scaffold(
        backgroundColor: const Color(0xFFf8f8f6),  //const Color(0xFFF8F5F2),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () => changeActivePage(0),
                  icon: Icon(
                    Icons.home,
                    color:  _activeIndex == 0 ? Colors.white : Colors.white70 ,
                  ),
              ),
              IconButton(onPressed: () => changeActivePage(1),
                  icon: Icon(Icons.camera_alt,
                    color: _activeIndex == 1 ? Colors.white : Colors.white70,)
              ),
              IconButton(onPressed: () => changeActivePage(2),
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
