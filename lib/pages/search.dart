import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid19/components/data_source.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: theme.primaryColor,
        primaryTextTheme: theme.primaryTextTheme,
        textTheme: theme.textTheme.copyWith(
            title: theme.textTheme.title
                .copyWith(color: theme.primaryTextTheme.title.color)));
  }

  @override
  String get searchFieldLabel => 'Country Name';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['Country'].toString().toLowerCase().contains(query))
            .toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    '${suggestionList[index]['Country']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    '${suggestionList[index]['TotalConfirmed']} Cases',
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
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xff503CAA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: DataSource(
                  data: suggestionList,
                  totalCases: suggestionList[index]['TotalConfirmed'],
                  totalDeaths: suggestionList[index]['TotalDeaths'],
                  activeCases: suggestionList[index]['TotalConfirmed'] -
                      (suggestionList[index]['TotalDeaths'] +
                          suggestionList[index]['TotalRecovered']),
                  totalRecovered: suggestionList[index]['TotalRecovered'],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
