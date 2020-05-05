import 'package:flutter/material.dart';
import 'package:flutter_covid19/pages/country_page.dart';
import 'package:flutter_covid19/pages/homepage.dart';
import 'package:flutter_covid19/pages/stat_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;

  var _pages = [
    new HomePage(),
    new StatPage(),
    new CountryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          }); // SetState
        }, // onTap
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepPurple,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.equalizer), title: Text("Statistics")),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.flag), title: Text("All Countries")),
        ],
      ),
      body: Container(child: _pages[_currentTabIndex]),
    );
  }
}
