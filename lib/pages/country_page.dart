import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid19/components/data_source.dart';
import 'package:flutter_covid19/network_services.dart';
import 'package:flutter_covid19/pages/search.dart';
import 'package:number_display/number_display.dart';
import 'package:provider/provider.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final display = createDisplay(
    length: 12,
    separator: ',',
  );

  List countryData;
  List defaultCountryData;

  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> subscription;
  String networkState;

  void checkConnectivity() async {
    // subscribe to connectivity change
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      var conn = getConnectionValue(result);
      if (mounted) {
        setState(() {
          networkState = conn;
        });
      }
    });
  }

  // Method to convert connectivity to a string value;
  String getConnectionValue(var connectivityResult) {
    String status = '';
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        status = 'mobile';
        break;
      case ConnectivityResult.wifi:
        status = 'wifi';
        break;
      case ConnectivityResult.none:
        status = 'none';
        break;
      default:
        status = 'none';
        break;
    }
    return status;
  }

  List sortList = [
    'Alphabet',
    'Highest Cases',
    'Lowest Cases',
    'Highest Deaths',
    'Lowest Deaths',
    'Highest Recovered',
    'Lowest Recovered'
  ];
  String sortString = 'Alphabet';

  DropdownButton<dynamic> dropDownMenu() {
    List<DropdownMenuItem> dropdownItems = [];
    for (int i = 0; i < sortList.length; i++) {
      String sort = sortList[i];
      var newItem = DropdownMenuItem(
        child: Text(
          sort,
          style: TextStyle(color: Colors.grey[600]),
        ),
        value: sort,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<dynamic>(
      value: sortString,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          sortString = value;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<NetworkServices>(context);
    data.getSummaryStat();

    countryData = data.allCountriesStat;
    defaultCountryData = data.allCountriesStat;
    if (countryData != null) {
      if (sortString == 'Alphabet') {
        countryData = defaultCountryData;
      } else if (sortString == 'Highest Deaths') {
        countryData
            .sort((a, b) => (b['TotalDeaths']).compareTo(a['TotalDeaths']));
      } else if (sortString == 'Lowest Deaths') {
        countryData
            .sort((b, a) => (b['TotalDeaths']).compareTo(a['TotalDeaths']));
      } else if (sortString == 'Highest Recovered') {
        countryData.sort(
            (a, b) => (b['TotalRecovered']).compareTo(a['TotalRecovered']));
      } else if (sortString == 'Lowest Recovered') {
        countryData.sort(
            (b, a) => (b['TotalRecovered']).compareTo(a['TotalRecovered']));
      } else if (sortString == 'Highest Cases') {
        countryData.sort(
            (a, b) => (b['TotalConfirmed']).compareTo(a['TotalConfirmed']));
      } else if (sortString == 'Lowest Cases') {
        countryData.sort(
            (b, a) => (b['TotalConfirmed']).compareTo(a['TotalConfirmed']));
      } else {
        countryData = defaultCountryData;
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search(countryData));
            },
          )
        ],
        title: Text('All Countries Stats'),
      ),
      body: Builder(builder: (_) {
        if (networkState == 'none') {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/loadingg.png'),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Check your Internet Connection!!!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return data.loading && countryData == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Sort Country By:',
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[600]),
                        ),
                        dropDownMenu(),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: countryData == null ? 0 : countryData.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '${countryData[index]['Country']}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    '${display(countryData[index]['TotalConfirmed'])} Cases',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Container(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                  color: Color(0xff503CAA),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                  ),
                                ),
                                child: DataSource(
                                  data: countryData,
                                  totalCases: countryData[index]
                                      ['TotalConfirmed'],
                                  totalDeaths: countryData[index]
                                      ['TotalDeaths'],
                                  activeCases: countryData[index]
                                          ['TotalConfirmed'] -
                                      (countryData[index]['TotalDeaths'] +
                                          countryData[index]['TotalRecovered']),
                                  totalRecovered: countryData[index]
                                      ['TotalRecovered'],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
