import 'package:flutter/material.dart';
import 'package:flutter_covid19/components/status_panel.dart';
import 'package:number_display/number_display.dart';

class DataPanel extends StatelessWidget {
  final Map data;

  DataPanel({this.data});

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
            count: display(data['TotalConfirmed']) ?? '',
          ),
          StatusPanel(
            title: 'Active Cases',
            panelColor: Colors.white,
            textColor: Colors.blue[800],
            count: display(data['TotalConfirmed'] -
                    (data['TotalRecovered'] + data['TotalDeaths'])) ??
                '',
          ),
          StatusPanel(
            title: 'Total Recovered',
            panelColor: Colors.white,
            textColor: Colors.green[800],
            count: display(data['TotalRecovered']) ?? '',
          ),
          StatusPanel(
            title: 'Total Deaths',
            panelColor: Colors.white,
            textColor: Colors.red[800],
            count: display(data['TotalDeaths']) ?? '',
          ),
        ],
      ),
    );
  }
}
