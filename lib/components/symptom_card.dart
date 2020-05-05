import 'package:flutter/material.dart';

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  SymptomCard({
    this.image,
    this.title,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Color(0xFF4056C6).withOpacity(.15),
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: Color(0xFFB7B7B7).withOpacity(.16),
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage(image),
            height: 90.0,
            width: 90.0,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
