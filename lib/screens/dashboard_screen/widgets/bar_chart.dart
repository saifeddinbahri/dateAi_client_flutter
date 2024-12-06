import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart'; // Pour utiliser NumberFormat

class RepartitionMaladies extends StatefulWidget {
  const RepartitionMaladies({super.key});

  @override
  _RepartitionMaladiesState createState() => _RepartitionMaladiesState();
}

class _RepartitionMaladiesState extends State<RepartitionMaladies> {
  String selectedChips = 'mal3';
  List<String> chips = [
    'mal1',
    'mal2',
    'mal3',
    'mal4',
    'mal5',
    'mal6',
  ];

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
                  BorderRadius.circular(10), // Réduire l'épaisseur
                  dataSource: chartData,
                  width: 0.4, // Réduire la largeur des colonnes
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  highValueMapper: (ChartColumnData data, _) =>
                  data.high! / 8000, // Convertir en pourcentage
                  lowValueMapper: (ChartColumnData data, _) =>
                  data.low! / 8000, // Convertir en pourcentage
                  pointColorMapper: (ChartColumnData data, _) => data.color,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Year 2024',
              style: TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: FittedBox(
                child: Wrap(
                  spacing: 8,
                  children: chips.map((category) {
                    return ChoiceChip(
                      label: Text(category),
                      labelStyle: TextStyle(
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
            ),
          ],
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

final List<ChartColumnData> chartData = <ChartColumnData>[
  ChartColumnData("malad1", 2600, 5000, const Color(0xFF1A2902)),
  ChartColumnData("malad2", 1800, 3000, const Color(0xFF344C11)),
  ChartColumnData("malad3", 3200, 6000, const Color(0xFFAEC09A)),
  ChartColumnData("malad4", 3800, 5000, const Color(0xFF797641)),
  ChartColumnData("malad5", 2000, 4000, const Color(0xFF583E26)),
  ChartColumnData("malad6", 3000, 7000, const Color(0xFFD9A037)),
];