import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/forecast_model.dart';

class ForecastProvider extends ChangeNotifier {
  List<ListElement> list = [];

  int get getForecastLength => list.length;

  List<ListElement> get getForecastList => list;

  void setList(List<ListElement> forecastList) {
    list = forecastList;
    for (ListElement ele in list) {
      print(ele.weather.first.icon);
    }
    notifyListeners();
  }
}
