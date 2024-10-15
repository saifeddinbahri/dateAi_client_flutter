import 'package:date_ai/screens/login_screen/login_screen.dart';
import 'package:date_ai/screens/signup/signup_screen.dart';
import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:flutter/material.dart';

import '../../widgets/buttons/primary_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
    _pageController = PageController(viewportFraction: 0.84);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    _tabController.animateTo(index);
  }

  Widget _carouselItem(
      String image,
      String text1,
      String text2,
      ScreenSize size,
      ScreenPadding padding) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: padding.horizontal
      ),
      child: SizedBox(
        height: size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                    
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02,),
            Text(
              text1,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height*0.003,),
            Text(
              text2,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = ScreenPadding(context);
    final screenSize = ScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: screenSize.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: screenSize.height * 0.07,
            ),
            Text(
              'DateAI',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenSize.height * 0.03),
            Expanded(
              child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: [
                    _carouselItem(
                    'assets/images/landing_1.jpg',
                        'Aliquam quaerat voluptatem?',
                        'Furam orum duma!',
                        screenSize,
                        padding
                    ),
                    _carouselItem(
                        'assets/images/landing_2.jpg',
                        'Lorem ipsum dolor sit ame',
                        'Totam rem aperiam',
                        screenSize,
                        padding
                    ),
                    _carouselItem(
                        'assets/images/landing_3.jpg',
                        'Nemo enim ipsam voluptatem',
                        'Ut enim ad minima veniam',
                        screenSize,
                        padding
                    ),
                  ]
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          color: _tabController.index == 0 ?
                          Theme.of(context).colorScheme.onTertiaryFixed :
                          Theme.of(context).colorScheme.tertiaryFixed
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.04,),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tabController.index == 1 ?
                        Theme.of(context).colorScheme.onTertiaryFixed :
                        Theme.of(context).colorScheme.tertiaryFixed
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.04,),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          color: _tabController.index == 2 ?
                          Theme.of(context).colorScheme.onTertiaryFixed :
                          Theme.of(context).colorScheme.tertiaryFixed
                      ),
                    ),
                  ]
              ),
            ),
            SizedBox(height: screenSize.height*0.05,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding.horizontal),
              child: PrimaryButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()
                      ),
                    );
                  },
                  context: context,
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary
                    ),
                  ),
              ),
            ),
            SizedBox(height: screenSize.height*0.01,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding.horizontal),
              child: TextButton(
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()
                    ),
                  );
                },
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Log In',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height*0.025)
          ],
        ),
      ),
    );
  }
}
