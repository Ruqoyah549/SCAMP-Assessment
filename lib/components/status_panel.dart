import 'package:flutter/material.dart';

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: panelColor,
      ),
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      height: 60,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 15, color: textColor),
          ),
          Text(
            count ?? '',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
          )
        ],
      ),
    );
  }
}
