import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MyPieChart extends StatelessWidget {
  final Map<String, double> dataMap;

  MyPieChart(this.dataMap);

  final List<Color> colorList = [
    Colors.blue[700],
    Colors.green[700],
    Colors.red[700],
  ];

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32.0,
      chartRadius: MediaQuery.of(context).size.width / 2.7,
      showChartValuesInPercentage: true,
      showChartValues: true,
      showChartValuesOutside: false,
      chartValueBackgroundColor: Colors.grey[200],
      colorList: colorList,
      showLegends: true,
      legendPosition: LegendPosition.right,
      decimalPlaces: 1,
      showChartValueLabel: true,
      initialAngle: 0,
      chartValueStyle: defaultChartValueStyle.copyWith(
        color: Colors.blueGrey[900].withOpacity(0.9),
      ),
      chartType: ChartType.disc,
    );
  }
}
