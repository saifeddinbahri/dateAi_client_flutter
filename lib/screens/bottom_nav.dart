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
  List<Widget> _pages = [] ;
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
      const HomeScreen(),
      const HistoryScreen(),
    ];
  }


  @override
  Widget build(BuildContext context) {
    final screenPadding = ScreenPadding(context);
    final screenSize = ScreenSize(context);
    final theme = ThemeHelper(context);

    return Scaffold(
        backgroundColor: const Color(0xFFF8F5F2),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            right: screenPadding.horizontal,
            left: screenPadding.horizontal,
            bottom: screenSize.height * 0.01
          ),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(30),
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
                    icon: Icon(Icons.history,
                      color: _activeIndex == 1 ? Colors.white : Colors.white70,)
                ),
              ],
            ),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(
              right: screenPadding.horizontal,
              left: screenPadding.horizontal,
              top: screenSize.height * 0.05
            ),
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _pages[_activeIndex],
            ),
        )
    );
  }
}
