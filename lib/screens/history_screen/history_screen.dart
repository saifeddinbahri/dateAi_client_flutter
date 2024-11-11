import 'package:date_ai/utils/fake_data.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _allScanned = FakeData.scanned;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);

    return Column(
      children: [
        Expanded(child: ListView.builder(
          itemCount: _allScanned.length,
          itemBuilder: (context, index) {
            return _scannedItem(
                _allScanned[index]['image']!,
                _allScanned[index]['date']!,
                _allScanned[index]['status']!,
            );
          },
        )
        ),
      ],
    );
  }

  Widget _scannedItem(String imageURL, String date, String status) {
    final screenSize = ScreenSize(context);
    final theme = ThemeHelper(context);

    return Container(
      height: screenSize.height * 0.43,
      margin: EdgeInsets.only(
          bottom: screenSize.height * 0.025
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
              height: screenSize.height * 0.33,
              width: screenSize.width ,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loading) {
                if (loading != null) {
                  return Shimmer.fromColors(
                    baseColor: theme.colorScheme.inversePrimary.withOpacity(0.1),
                    highlightColor: theme.colorScheme.inversePrimary!.withOpacity(0.03),
                    child: Container(
                      height: screenSize.height * 0.33,
                      width: screenSize.width,
                      color: Colors.white,
                    ),
                  );
                }
                return child;
              },
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
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
