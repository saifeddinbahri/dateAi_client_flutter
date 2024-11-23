import 'package:date_ai/utils/fake_data.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/drawer_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _latestRes = FakeData.scanned;

  @override
  Widget build(BuildContext context) {
    final drawerController = Provider.of<DrawerControllerProvider>(context, listen: false);
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
                onPressed: drawerController.openDrawer,
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
              _topAnomaliesItem(3,16, 'Black Scorc', '20%', context),
            ],
          ),
        ),
        SizedBox(height: screenSize.height * 0.03,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Scans',
              style: theme.textStyle.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 19,
              ),
            ),
            TextButton(
                onPressed: null,
                child: Text(
                  'see all',
                  style: theme.textStyle.titleMedium!.copyWith(
                      color: Colors.black45
                  ),
                )
            ),
          ],
        ),
        SizedBox(
          width: screenSize.width * 0.5,
          height: screenSize.height * 0.27,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _latestRes.length,
              itemBuilder: (context, index) {
                return _latestResultItem(
                _latestRes[index]['image']!,
                _latestRes[index]['date']!,
                _latestRes[index]['status']!
                );
              }
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


  Widget _latestResultItem(String imageURL, String date, String status) {
    final screenSize = ScreenSize(context);
    final theme = ThemeHelper(context);

    return Container(
      width: screenSize.width * 0.8,
      margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.025
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24)
            ),
            child: Image.network(
              imageURL,
              fit: BoxFit.fill,
              height: screenSize.height * 0.18,
              width: screenSize.width ,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loading) {
                if (loading != null) {
                  return Shimmer.fromColors(
                    baseColor: theme.colorScheme.inversePrimary.withOpacity(0.1),
                    highlightColor: theme.colorScheme.inversePrimary!.withOpacity(0.03),
                    child: Container(
                      height: screenSize.height * 0.18,
                      width: screenSize.width,
                      color: Colors.white,
                    ),
                  );
                }
                return child;
              },
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
            ),
            child: Text(
              'Scanned on $date',
              style: theme.textStyle.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.01,),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
            ),
            child: Text(
              'Anomaly: $status',
              style: theme.textStyle.bodyMedium!.copyWith(
                  color: Colors.black54
              ),
            ),
          ),
        ],
      ),
    );
  }
}
