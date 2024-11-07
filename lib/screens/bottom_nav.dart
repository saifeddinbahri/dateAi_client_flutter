import 'package:date_ai/screens/home_screen/history_screen/history_screen.dart';
import 'package:date_ai/screens/home_screen/home_screen.dart';
import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';
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
        bottomNavigationBar: Container(
          color: theme.colorScheme.secondaryContainer,
          width: screenSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () => changeActivePage(0), icon: const Icon(Icons.home)),
              IconButton(onPressed: () => changeActivePage(1), icon: const Icon(Icons.history)),
            ],
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _pages[_activeIndex],
        )
    );
  }
}
