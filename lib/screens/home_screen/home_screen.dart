import 'package:date_ai/services/stat_service.dart';
import 'package:date_ai/utils/fake_data.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _latestRes = FakeData.scanned;
  final _statService = StatService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Map<String, dynamic>>? _getStatData() async {
    final Map<String, dynamic> _statData = {
      'total': 0,
      'infected': 0,
    };
    var res = await _statService.execute();
    if (res.success) {
      _statData['total'] = res.data['stats']['totalScans'];
      _statData['infected'] = res.data['stats']['infectedScans'];
    }
    return _statData;
  }

  @override
  Widget build(BuildContext context) {
    //final drawerController = Provider.of<DrawerControllerProvider>(context, listen: false);
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);

    return SingleChildScrollView(
      child: FutureBuilder<Map<String, dynamic>>(
        future: _getStatData(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: screenSize.height * 0.8,
                width: screenSize.width,
                child: Center(child: CircularProgressIndicator(color: theme.colorScheme.primary,),)
            );
          } else if (snapshot.hasData) {
              final data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      numberStats(context, data!['total'],'Total scans', Icons.query_stats, '2.1%'),
                      numberStats(context, data!['infected'],'Anomalies', Icons.report_problem, '0.7%'),
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
                          'Top anomalies in Tunisia',
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
          return SizedBox(
              height: screenSize.height * 0.8,
              width: screenSize.width,
              child: Center(child: Text('No internet', style: theme.textStyle.titleMedium,),)
          );
        },
      ),
    );
  }

  Widget numberStats(BuildContext context, int count, String text,IconData icon, String nbStats) {
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);

    return Container(
      height: screenSize.width * 0.445,
      width: screenSize.width * 0.445,
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.04,
          vertical: screenSize.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.secondary,),
              SizedBox(width: screenSize.width * 0.05,),
              Text(
                text,
                style: theme.textStyle.titleMedium!.copyWith(
                    color: Colors.black45
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: screenSize.width * 0.08,),
          Text(
            '$count',
            style: theme.textStyle.headlineLarge!.copyWith(
                fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.greenAccent,
                    size: theme.textStyle.bodyMedium!.fontSize,
                  ),
                  SizedBox(width: screenSize.width*0.015,),
                  Text(
                    nbStats,
                    style: theme.textStyle.bodyMedium!.copyWith(
                        color: Colors.greenAccent
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: screenSize.width*0.01,),
                  Text(
                    'vs last 7 days',
                    style: theme.textStyle.bodyMedium!.copyWith(
                        color: Colors.black45
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
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
