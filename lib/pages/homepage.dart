import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid19/components/symptom_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 TRACKER'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: Carousel(
              images: [
                ExactAssetImage('assets/images/covid-template4.jpg'),
                ExactAssetImage('assets/images/covid-template23.jpg'),
                ExactAssetImage('assets/images/covid-template26.jpg'),
                ExactAssetImage('assets/images/covid-template16.jpg'),
                ExactAssetImage('assets/images/covid-template13.jpg'),
              ],
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.black87,
              indicatorBgPadding: 5.0,
              dotBgColor: Colors.deepPurple.withOpacity(0.5),
              borderRadius: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Prevention',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SymptomCard(
                  image: 'assets/images/w-hands.png',
                  title: "Wash Hands",
                  isActive: true,
                ),
                SymptomCard(
                  image: 'assets/images/home.png',
                  title: "Stay Home",
                ),
                SymptomCard(
                  image: 'assets/images/wear_mask.png',
                  title: "Wear Mask",
                ),
                SymptomCard(
                  image: 'assets/images/s-distance.png',
                  title: "Social Distance",
                ),
                SymptomCard(
                  image: 'assets/images/m-care.png',
                  title: "Sick? Call",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Symptoms',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SymptomCard(
                  image: 'assets/images/wash_hands.png',
                  title: "Fever",
                  isActive: true,
                ),
                SymptomCard(
                  image: 'assets/images/wash_hands.png',
                  title: "Dry Cough",
                ),
                SymptomCard(
                  image: 'assets/images/wear_mask.png',
                  title: "Headache",
                ),
                SymptomCard(
                  image: 'assets/images/wash_hands.png',
                  title: "Tiredness",
                ),
                SymptomCard(
                  image: 'assets/images/wash_hands.png',
                  title: "Runny Nose",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
