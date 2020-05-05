import 'package:flutter/material.dart';
import 'package:flutter_covid19/components/status_panel.dart';
import 'package:number_display/number_display.dart';

class DataSource extends StatelessWidget {
  final List data;
  final int totalCases;
  final int totalDeaths;
  final int totalRecovered;
  final int activeCases;

  DataSource(
      {this.data,
      this.totalCases,
      this.totalDeaths,
      this.activeCases,
      this.totalRecovered});

  final display = createDisplay(
    length: 12,
    separator: ',',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10.0),
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'Total Cases',
            panelColor: Colors.white,
            textColor: Colors.yellow[800],
            count: display(totalCases) ?? '',
          ),
          StatusPanel(
            title: 'Active Cases',
            panelColor: Colors.white,
            textColor: Colors.blue[800],
            count: display(activeCases) ?? '',
          ),
          StatusPanel(
            title: 'Total Recovered',
            panelColor: Colors.white,
            textColor: Colors.green[800],
            count: display(totalRecovered) ?? '',
          ),
          StatusPanel(
            title: 'Total Deaths',
            panelColor: Colors.white,
            textColor: Colors.red[800],
            count: display(totalDeaths) ?? '',
          ),
        ],
      ),
    );
  }
}
