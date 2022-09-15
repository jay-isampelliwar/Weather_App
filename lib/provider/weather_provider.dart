import 'package:flutter/cupertino.dart';

class WeatherProvider extends ChangeNotifier {
  String? city;
  double? temp;
  double? feelsLike;
  int? humidity;
  int? id;
  int? pressure;
  String? conuntry;
  String? main;
  String? description;
  String? icon;
  double? speed;
  bool isLoaded = false;

  String? getCity() {
    if (city != null) {
      String curCity = city![0];
      curCity = curCity.toUpperCase();
      curCity = curCity + city!.substring(1, city!.length);

      return curCity;
    }
    return null;
  }

  int? get getPressure => pressure;

  String? get getCountry => conuntry;
  String? getTemp() {
    var curTemp = temp?.toStringAsFixed(0);
    return "$curTemp°";
  }

  double? get getFeelsLike => feelsLike;
  double? get getSpeed => speed;
  int? get getId => id;
  int? get getHumidity => humidity;
  String? get getIcon => icon;
  String? get getMain => main;
  String? get getDescription => description;
  bool get dataIsLoaded => isLoaded;

  void setTemp(double? temp) {
    this.temp = temp;
    notifyListeners();
  }

  void setCity(String city) {
    this.city = city;
  }

  void setCountry(String country) {
    conuntry = country;
  }

  void setFeelsLike(double? feelsLike) {
    this.feelsLike = feelsLike;
  }

  void setPressure(int? pressure) {
    this.pressure = pressure;
  }

  void setSpeed(double? speed) {
    this.speed = speed;
  }

  void setId(int? id) {
    this.id = id;
  }

  void setHumidity(int? humidity) {
    this.humidity = humidity;
  }

  void setIcon(String? icon) {
    this.icon = icon;
  }

  void setMain(String? main) {
    this.main = main;
  }

  void setDescription(String? description) {
    this.description = description;
  }

  void setIsLoaded(bool update) {
    isLoaded = update;
    notifyListeners();
  }
}
