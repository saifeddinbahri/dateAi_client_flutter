import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialBarChart extends StatelessWidget {
  const RadialBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> _Labels = {
      'sains': const Color(0xFF778D45),
      'defectuex': const Color(0xFF1A2902),
    };

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: SfRadialGauge(
                      axes: [
                        RadialAxis(
                          labelOffset: 0,
                          pointers: const [
                            RangePointer(
                              value: 20,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Color(0xFF778D45),
                              width: 24,
                            ),
                          ],
                          axisLineStyle: const AxisLineStyle(
                            thickness: 24,
                          ),
                          startAngle: 130,
                          endAngle: 130,
                          showLabels: false,
                          showTicks: false,
                          annotations: const [
                            GaugeAnnotation(
                              widget: Text(
                                '77%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Colors.grey,
                                ),
                              ),
                              positionFactor: 0.2,
                            ),
                          ],
                        ),
                        RadialAxis(
                          pointers: const [
                            RangePointer(
                              value: 20,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Color(0xFF1A2902),
                              width: 24,
                            ),
                          ],
                          startAngle: 90,
                          endAngle: 90,
                          showLabels: false,
                          showTicks: false,
                          showAxisLine: false,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    _Labels.length,
                        (index) => LabelsChart(
                      _Labels.keys.elementAt(index),
                      _Labels.values.elementAt(index),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              "Les arbres sains et défectueux",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }


  Widget LabelsChart(String label, Color color) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}