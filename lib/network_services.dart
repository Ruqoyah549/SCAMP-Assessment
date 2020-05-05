import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_covid19/components/toast_message.dart';
import 'package:http/http.dart' as http;

class NetworkServices extends ChangeNotifier {
  final summaryUrl = 'https://api.covid19api.com/summary';

  bool _isLoading = true;
  bool get loading => _isLoading;

  List _allCountriesStat;
  Map _nigeriaStat;
  Map _globalStat;

  List get allCountriesStat => _allCountriesStat;
  Map get nigeriaStat => _nigeriaStat;
  Map get globalStat => _globalStat;

  void _setAllCountriesStat(value) {
    _allCountriesStat = value;
    notifyListeners();
  }

  void _setNigeriaStat(value) {
    _nigeriaStat = value;
    notifyListeners();
  }

  void _setGlobalStat(value) {
    _globalStat = value;
    notifyListeners();
  }

  getSummaryStat() async {
    try {
      await http.get(summaryUrl).then((res) {
        if (res.statusCode == 200) {
          var data = json.decode(res.body);
          _globalStat = data['Global'];
          _nigeriaStat = data['Countries'][161];
          _allCountriesStat = data['Countries'];
          _setGlobalStat(_globalStat);
          _setNigeriaStat(_nigeriaStat);
          _setAllCountriesStat(_allCountriesStat);
        }
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      ToastMessage.toast('Failed to load from Internet');
    }
  }
}
