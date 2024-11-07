import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:date_ai/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Welcome',
                  style: theme.textStyle.headlineMedium,
                ),
                SizedBox(width: screenSize.width*0.02,),
                Text(
                  'Eya',
                  style: theme.textStyle.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.menu,
                  size: screenSize.width * 0.085,
                ),
            ),
          ],

        ),
        Text(
          "Start identifying date tree leaf diseases.",
          style: theme.textStyle.titleMedium!.copyWith(
            color: Colors.black45
          ),
        ),
        SizedBox(height: screenSize.height * 0.03,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            numberStats(74,'Total scans', context),
            numberStats(66,'Anomaly detected', context),
          ],
        ),
        SizedBox(height: screenSize.height * 0.01,),
        Container(
          height: screenSize.height * 0.25,
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.02
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Top anomalies',
                style: theme.textStyle.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: screenSize.height * 0.03,),
              _topAnomaliesItem(1,30, 'Black Scorc', '48%', context),
              SizedBox(height: screenSize.height * 0.01,),
              const Divider(height: 2,),
              SizedBox(height: screenSize.height * 0.01,),
              _topAnomaliesItem(2,20, 'Black Scorc', '32%', context),
              SizedBox(height: screenSize.height * 0.01,),
              const Divider(height: 2,),
              SizedBox(height: screenSize.height * 0.01,),
              _topAnomaliesItem(3,16, 'Black Scorc', '20%%', context),
            ],
          ),
        ),
        SizedBox(height: screenSize.height * 0.03,),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05,
                vertical: screenSize.height * 0.02
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Latest results',
                  style: theme.textStyle.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03,)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget numberStats(int count, String text, BuildContext context) {
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);
    return Container(
      height: screenSize.height * 0.12,
      width: screenSize.width * 0.45,
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.05,
          vertical: screenSize.height * 0.02
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$count',
            style: theme.textStyle.titleLarge!.copyWith(
                fontWeight: FontWeight.w600
            ),
            textAlign: TextAlign.start,
          ),

          Text(
              text,
              style: theme.textStyle.bodyLarge,
              textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _topAnomaliesItem(int order, int count, String name,String percentage, BuildContext context) {
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$order.',
          style: theme.textStyle.labelLarge,
        ),
        Text(
          name,
          style: theme.textStyle.labelLarge,
        ),
        Text(
          '$count',
          style: theme.textStyle.labelLarge,
        ),
        Text(
          percentage,
          style: theme.textStyle.labelLarge,
        ),
      ],
    );
  }

  Widget _latestResultItem(String image, String date,) {
    return Container();
  }
}
