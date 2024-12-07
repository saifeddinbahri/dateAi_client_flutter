import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:date_ai/screens/dashboard_screen/widgets/bar_chart.dart';
import 'package:date_ai/screens/dashboard_screen/widgets/courbe.dart';
import 'package:date_ai/screens/dashboard_screen/widgets/radial_bar_chart.dart';
import 'package:date_ai/services/treatment_service.dart';
import 'package:flutter/material.dart';

import '../../services/stat_service.dart';
import '../../utils/screen_size.dart';
import '../../utils/theme_helper.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _statService = StatService();
  final _treatmentService = TreatmentService();

  Future<Map<String, dynamic>>? _getStatData() async {
    final Map<String, dynamic> _statData = {
      'total': 0,
      'infected': 0,
      'healthy': 0,
      'treatments': 0,
      'statData': null,
    };

    var treatments = await _treatmentService.execute();
    var res = await _statService.execute();
    if (res.success && treatments.success) {
      _statData['total'] = res.data['stats']['totalScans'];
      _statData['infected'] = res.data['stats']['infectedScans'];
      _statData['healthy'] = res.data['stats']['healthyScans'];
      _statData['treatments'] = treatments.data['totalTreatments'];
      _statData['statData'] = res.data['stats'];
    }
    return _statData;
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = ThemeHelper(context);

    return FutureBuilder<Map<String, dynamic>>(
        future: _getStatData(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: screenSize.height * 0.8,
                width: screenSize.width,
                child: Center(child: CircularProgressIndicator(color: theme.colorScheme.primary,),)
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Suivi de l'état de l'oasis.",
                        style: theme.textStyle.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/icons/Palimier.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                              'Palm trees',
                              style: theme.textStyle.titleMedium
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  // Statistiques des palmiers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      numberStats(context, data!['total'],'Total', Icons.numbers, '2.1%'),
                      numberStats(context, data!['healthy'],'Healthy', Icons.report_problem, '0.7%'),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      numberStats(context, data!['treatments'],'Treatments', Icons.query_stats, '2.1%'),
                      numberStats(context, data!['infected'],'Infected', Icons.report_problem, '0.7%'),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  // Section "Dattes" avec le bouton "Voir tout"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/icons/Palimier.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                              'Palm trees',
                              style: theme.textStyle.titleMedium
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  const RadialBarChart(),

                  // Section des derniers scans
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Les maladies',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Voir tout',
                          style: theme.textStyle.titleMedium
                              ?.copyWith(color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.02),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: screenSize.width * 0.8,
                          height: screenSize.height *0.7,
                          margin: EdgeInsets.only(right: 22),
                          child: RepartitionMaladies(diseaseData: data['statData'],),
                        ),
                        Container(
                          width: screenSize.width * 0.8,
                          height: screenSize.height *0.7,
                          margin: EdgeInsets.only(right: 22),
                          child: const RepartitionMaladiesCourbe(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            );
          }
          return SizedBox(
              height: screenSize.height * 0.8,
              width: screenSize.width,
              child: Center(child: Text('No internet', style: theme.textStyle.titleMedium,),)
          );
        }
    );

  }


  Widget numberStats(BuildContext context, int count, String text,IconData icon, String nbStats) {
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);

    return Container(
      height: screenSize.width * 0.3,
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
          SizedBox(height: screenSize.width * 0.03,),
          Text(
            '$count',
            style: theme.textStyle.headlineLarge!.copyWith(
                fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
