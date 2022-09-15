// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  WeatherModel({
    required this.weather,
    required this.main,
    required this.wind,
    required this.name,
    required this.sys,
  });

  List<Weather> weather;
  Main main;
  Sys sys;
  Wind wind;
  String name;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      weather:
          List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      main: Main.fromJson(json["main"]),
      wind: Wind.fromJson(json["wind"]),
      name: json["name"],
      sys: Sys.formJson(json["sys"]));

  Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "wind": wind.toJson(),
        "name": name,
      };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
  });

  double? temp;
  int? pressure;
  double? feelsLike;
  int? humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        pressure: json["pressure"],
        feelsLike: json["feels_like"].toDouble(),
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "pressure": pressure,
        "feels_like": feelsLike,
        "humidity": humidity,
      };
}

class Weather {
  Weather(
      {required this.id,
      required this.description,
      required this.icon,
      required this.main});

  int? id;
  String? description;
  String? icon;
  String? main;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      id: json["id"],
      description: json["description"],
      icon: json["icon"],
      main: json["main"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "main": main,
        "icon": icon,
      };
}

class Wind {
  Wind({
    required this.speed,
  });

  double? speed;

  factory Wind.fromJson(Map<String, dynamic> json) =>
      Wind(speed: json["speed"].toDouble());

  Map<String, dynamic> toJson() => {
        "speed": speed,
      };
}

class Sys {
  Sys({
    required this.country,
  });

  String country;

  factory Sys.formJson(Map<String, dynamic> json) =>
      Sys(country: json["country"]);

  Map<String, dynamic> toJson() => {
        "country": country,
      };
}
