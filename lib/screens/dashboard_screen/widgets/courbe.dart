import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RepartitionMaladiesCourbe extends StatelessWidget {
  const RepartitionMaladiesCourbe({super.key});

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
              children: [
                Text(
                  'Les Top anomalies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_upward,
                  color: Color(0xFFAEC670),
                ),
              ],
            ),
            SfCartesianChart(
              plotAreaBackgroundColor: Colors.transparent,
              margin: const EdgeInsets.symmetric(vertical: 10),
              borderColor: Colors.transparent,
              borderWidth: 0,
              plotAreaBorderWidth: 0,
              primaryXAxis: const CategoryAxis(isVisible: true),
              primaryYAxis: const NumericAxis(
                isVisible: true,
                minimum: 0,
                maximum: 30,
                interval: 5,
              ),
              series: <CartesianSeries>[
                // Première courbe
                LineSeries<ChartColumnData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  yValueMapper: (ChartColumnData data, _) => data.y,
                  color: const Color(0xFFE9EDF7),
                  width: 2,
                ),

                LineSeries<ChartColumnData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  yValueMapper: (ChartColumnData data, _) => data.y1,
                  color: const Color.fromARGB(255, 122, 170, 146),
                  width: 2,
                ),
                LineSeries<ChartColumnData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartColumnData data, _) => data.x,
                  yValueMapper: (ChartColumnData data, _) => data.y2,
                  color: const Color(0xFF0A74DA),
                  width: 2,
                ),
              ],
            ),
            const Text(
              'Avancement des courbes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Définition des données chartData
class ChartColumnData {
  ChartColumnData(this.x, this.y, this.y1, this.y2);
  final String x;
  final double? y;
  final double? y1;
  final double? y2; // Ajout d'une nouvelle variable pour la troisième courbe
}

// Données de test
final List<ChartColumnData> chartData = <ChartColumnData>[
  ChartColumnData("Lun", 10, 15, 5),
  ChartColumnData("Mar", 12, 17, 6),
  ChartColumnData("Mer", 13, 18, 7),
  ChartColumnData("Jeu", 14, 20, 9),
  ChartColumnData("Ven", 15, 22, 12),
  ChartColumnData("Sam", 18, 23, 14),
  ChartColumnData("Dim", 20, 25, 18),
];