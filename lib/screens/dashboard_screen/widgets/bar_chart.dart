import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../../../services/stat_service.dart'; // Pour utiliser NumberFormat

class RepartitionMaladies extends StatefulWidget {
  const RepartitionMaladies({super.key, required this.diseaseData});
  final Map<String, dynamic>? diseaseData;
  @override
  _RepartitionMaladiesState createState() => _RepartitionMaladiesState();
}

class _RepartitionMaladiesState extends State<RepartitionMaladies> {
  String selectedChips = 'mal3';
  final _statService = StatService();




  List<ChartColumnData>? setData() {
    if(widget.diseaseData == null) {
      return null;
    }
    List<dynamic> dList = widget.diseaseData!['diseaseDistribution'];
    int colorIndex = 0;
    List<ChartColumnData> data = [];
    var dCount = widget.diseaseData!['infectedScans'];

    if (dList.isEmpty) return null;
    dList.forEach((e) {
      data.add(
          ChartColumnData(
              e['diseaseType'],
              0,
              calculatePercentage(dCount, e['count']),
              colors[colorIndex])
      );
      colorIndex = colorIndex + 1;
    });
    return data;
  }

  double calculatePercentage(int total, int count) {
    if (total == 0) {
      return 0;
    }

    double percentage = (count / total) * 100; // Calculate percentage
    return double.parse(percentage.toStringAsFixed(2)) * 100;
  }

  @override
  Widget build(BuildContext context) {
    const Color secondaryColor = Colors.white;

    return Card(
      color: secondaryColor,
      surfaceTintColor: secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Statistiques",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Statistiques des maladies détectées sur les palmiers',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16), // Utiliser une valeur pour padding
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 16),
            SfCartesianChart(
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              borderWidth: 0,
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(isVisible: false),
              primaryYAxis: NumericAxis(
                axisLine: const AxisLine(width: 0),
                majorTickLines: MajorTickLines(width: 0),
                majorGridLines: MajorGridLines(
                  width: 1,
                  color: Colors.black,
                  dashArray: <double>[5, 5],
                ),
                numberFormat: NumberFormat.percentPattern(),
                labelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                minimum: 0,
                maximum: 1, // La valeur maximale sera 100% = 1
                interval: 0.2,
              ),
              series: <CartesianSeries>[
                RangeColumnSeries<ChartColumnData, String>(
                  borderRadius:
                  BorderRadius.circular(10),
                  dataSource: setData(),
                  width: 0.4,
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  highValueMapper: (ChartColumnData data, _) =>
                  data.high! / 8000,
                  lowValueMapper: (ChartColumnData data, _) =>
                  data.low! / 8000,
                  pointColorMapper: (ChartColumnData data, _) => data.color,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Year 2024',
              style: TextStyle(color: Colors.grey),
            ),
            chips(),
          ],
        ),
      ),
    );
  }

  Widget chips() {
    if(widget.diseaseData == null) return const SizedBox();
    final theme = ThemeHelper(context);

    List<dynamic> dList = widget.diseaseData!['diseaseDistribution'];

    if (dList.isEmpty) return const SizedBox();
    List<String> chips = [];
    dList.forEach((e) {
      chips.add(e['diseaseType']);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: FittedBox(
        child: Wrap(
          spacing: 8,
          children: chips.map((category) {
            return ChoiceChip(
              label: Text(category),
              labelStyle: TextStyle(
                fontSize: theme.textStyle.labelLarge!.fontSize,
                color: selectedChips == category
                    ? Colors.white
                    : Colors.black,
              ),
              selectedColor:
              const Color(0xFFD7761B), // Hex couleur corrigée
              backgroundColor: Colors.grey.shade200,
              showCheckmark: false,
              selected: selectedChips == category,
              side: const BorderSide(width: 0, color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onSelected: (isSelected) {
                setState(() {
                  if (isSelected) {
                    selectedChips = category;
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ChartColumnData {
  ChartColumnData(this.x, this.low, this.high, this.color);
  final String x;
  final double? low;
  final double? high;
  final Color? color;
}

List<Color> colors = [
  const Color(0xFF1A2902),
  const Color(0xFF344C11),
  const Color(0xFFAEC09A),
  const Color(0xFF797641),
  const Color(0xFF583E26),
  const Color(0xFFD9A037),
];

