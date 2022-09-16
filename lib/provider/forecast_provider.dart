import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/forecast_model.dart';

class ForecastProvider extends ChangeNotifier {
  List<ListElement> forecastList = [];
  List<String> icons = [];
  bool isLoaded = false;

  int get length => forecastList.length;
  List<ListElement> get getForecastList => forecastList;
  List<String> get getIconList => icons;

  void setList(List<ListElement> list) {
    forecastList.clear();
    for (ListElement? listElement in list) {
      forecastList.add(listElement!);
    }
    setIcons();
    isLoaded = true;
    notifyListeners();
  }

  void setIsLoaded(bool val) {
    isLoaded = false;
    notifyListeners();
  }

  void setIcons() {
    for (ListElement listElement in forecastList) {
      String icon = listElement.weather.first.icon.toString();

      if (icon.length >= 9) {
        icons.add("${icon.substring(9).replaceAll('_', "").toLowerCase()}.png");
      }
    }
  }
}
