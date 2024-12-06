import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:date_ai/screens/camera_screen/camera_screen.dart';
import 'package:date_ai/screens/dashboard_screen/dashboard_screen.dart';
import 'package:date_ai/screens/favories_screen/favories_screen.dart';
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
      { 'screen': const DashboardScreen(), 'padding': true},
      { 'screen': const HistoryScreen(), 'padding': true},
      { 'screen': const FavoriteScreen(), 'padding': true},
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: drawerController.openDrawer,
            icon: Icon(
              Icons.menu,
              size: screenSize.width * 0.075,
            ),
          ),
          title: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black45,size: 28,),
              ),
              SizedBox(width: screenSize.width*0.03,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saif Eddine',
                    style: theme.textStyle.titleMedium,
                  ),
                  Text(
                    'Tunisia',
                    style: theme.textStyle.titleSmall!.copyWith(
                      color: Colors.black45
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              _drawerListItem(Icons.logout, 'Log out', _logout),
              _drawerListItem(Icons.library_books, 'Library', (){}),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CameraScreen())
            );
          },
          backgroundColor: Colors.white,
          child: Image.asset('assets/images/icons/scan.png', height: 30.0),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: const [Icons.home, Icons.query_stats, Icons.history, Icons.favorite],
            splashColor: Colors.white,
            gapLocation: GapLocation.center,
            inactiveColor: Colors.black45.withOpacity(0.5),
            activeColor: Colors.black,
            backgroundColor: Colors.white,
            activeIndex: _activeIndex,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: (index) => _changeActivePage(index),
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
        ),
        child: screen,
      );
    }
    return screen;
  }

  Widget _drawerListItem(IconData icon, String text, VoidCallback handleClicked) {
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);
    return ListTile(
      onTap: handleClicked,
      title: Row(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 24,
          ),
          SizedBox(width: screenSize.width * 0.02,),
          Text(
            text,
            style: theme.textStyle.titleMedium,
          )
        ],
      ),
    );
  }
}
