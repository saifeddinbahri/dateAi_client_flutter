import 'package:date_ai/screens/treatment_preview_screen/treatment_preview_screen.dart';
import 'package:date_ai/services/scan_history_service.dart';
import 'package:date_ai/utils/fake_data.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _allScanned = FakeData.scanned;
  final _scanHistoryService = ScanHistoryService();

  Future<List<dynamic>> _getHistory() async {
    var res = await _scanHistoryService.execute();
    if (res.success){
      List<dynamic>? data  = res.data['scans'];
      if (data != null && data.isNotEmpty) {
        return data;
      }
    }
    return [];
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);

    return FutureBuilder<List<dynamic>>(
        future: _getHistory(),
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(
            height: screenSize.height * 0.8,
            width: screenSize.width,
            child: Center(child: CircularProgressIndicator(color: theme.colorScheme.primary,),)
        );
      }
      if (snapshot.hasData) {
        var data = snapshot.data;
        return Column(
          children: [
            Expanded(child: ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return _scannedItem(
                  'https://img.freepik.com/free-photo/leaves-tropical-palm_23-2147829135.jpg?t=st=1731345775~exp=1731349375~hmac=70a6d94c6014fded77ac71ba3ca8a846d3b1544a5d5ddff6aee977599f38568d&w=996',
                  formatDate(data[index]['createdAt']),
                  data[index]['infected'] == true ? data[index]['diseaseType'] : 'Healthy',
                  data[index]['id'],
                );
              },
            )
            ),
          ],
        );
      }
      return SizedBox(
          height: screenSize.height * 0.8,
          width: screenSize.width,
          child: Center(child: Text('No internet', style: theme.textStyle.titleMedium,),)
      );
    });
  }

  Widget _scannedItem(String imageURL, String date, String status, String id) {
    final screenSize = ScreenSize(context);
    final theme = ThemeHelper(context);

    return GestureDetector(
      onTap: () {
        if (status != 'Healthy') {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => TreatmentPreviewScreen(
                    image: imageURL,
                    title: date,
                    disease: status,
                    id: id
                )
            ),
          );
        }
      },
      child: Container(
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
      ),
    );
  }
}
