// To parse this JSON data, do
//
//     final forecast = forecastFromJson(jsonString);

import 'dart:convert';

Forecast forecastFromJson(String str) => Forecast.fromJson(json.decode(str));

String forecastToJson(Forecast data) => json.encode(data.toJson());

class Forecast {
  Forecast({
    required this.list,
  });

  List<ListElement> list;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    required this.main,
    required this.weather,
    required this.dtTxt,
  });

  MainClass main;
  List<Weather> weather;
  DateTime dtTxt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        main: MainClass.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        dtTxt: DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toJson() => {
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "dt_txt": dtTxt.toIso8601String(),
      };
}

class MainClass {
  MainClass({
    required this.temp,
  });

  double temp;

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
      };
}

enum Pod { N, D }

final podValues = EnumValues({"d": Pod.D, "n": Pod.N});

class Weather {
  Weather({
    required this.main,
    required this.icon,
  });

  MainEnum? main;
  Icon? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: mainEnumValues.map[json["main"]],
        icon: iconValues.map[json["icon"]],
      );

  Map<String, dynamic> toJson() => {
        "main": mainEnumValues.reverse![main],
        "icon": iconValues.reverse![icon],
      };
}

enum Description { LIGHT_RAIN, MODERATE_RAIN, OVERCAST_CLOUDS }

final descriptionValues = EnumValues({
  "light rain": Description.LIGHT_RAIN,
  "moderate rain": Description.MODERATE_RAIN,
  "overcast clouds": Description.OVERCAST_CLOUDS
});

enum Icon { THE_10_N, THE_10_D, THE_04_D }

final iconValues = EnumValues(
    {"04d": Icon.THE_04_D, "10d": Icon.THE_10_D, "10n": Icon.THE_10_N});

enum MainEnum { RAIN, CLOUDS }

final mainEnumValues =
    EnumValues({"Clouds": MainEnum.CLOUDS, "Rain": MainEnum.RAIN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
