import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/city_list.dart';
import 'package:weather_app/provider/forecast_provider.dart';
import 'package:weather_app/provider/history.dart';
import 'package:weather_app/services/api_call_forecast.dart';

import '../utility/constants.dart';
import '../provider/weather_provider.dart';
import '../services/api_call_weather.dart';

class SerarchBox extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    CityList cityProvider = Provider.of<CityList>(context);
    return [
      IconButton(
        icon: Icon(
          Icons.add,
          color: Colors.grey.shade300,
          size: 28,
        ),
        onPressed: () {
          if (query.isNotEmpty) {
            cityProvider.addCity(query);
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back,
        size: 28,
        color: Colors.grey.shade300,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    History historyProivder = Provider.of<History>(context);
    CityList cityProvider = Provider.of<CityList>(context);
    for (String city in cityProvider.getCityList) {
      if (city.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(city);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            WeatherProvider weatherProvider =
                Provider.of<WeatherProvider>(context, listen: false);
            ForecastProvider forecastProvider =
                Provider.of<ForecastProvider>(context, listen: false);
            weatherProvider.setIsLoaded(false);
            forecastProvider.setIsLoaded(false);
            WeatherAPI.getData(weatherProvider, matchQuery[index]);
            ForecastAPI.getData(forecastProvider, matchQuery[index]);
            historyProivder.addItemInHistory(matchQuery[index]);
            print(matchQuery[index]);
            close(context, null);
          },
          title: Text(
            matchQuery[index],
            style: TextStyle(
              color: blackCon,
              fontSize: 18,
            ),
          ),
          leading: Icon(
            Icons.location_city,
            color: blackCon,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    History historyProivder = Provider.of<History>(context);
    CityList cityProvider = Provider.of<CityList>(context);
    for (String city in cityProvider.getCityList) {
      if (city.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(city);
      }
    }

    return query.isEmpty
        ? ListView.builder(
            itemCount: historyProivder.getLength,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  WeatherProvider weatherProvider =
                      Provider.of<WeatherProvider>(context, listen: false);
                  ForecastProvider forecastProvider =
                      Provider.of<ForecastProvider>(context, listen: false);
                  weatherProvider.setIsLoaded(false);
                  forecastProvider.setIsLoaded(false);
                  WeatherAPI.getData(
                      weatherProvider, historyProivder.history_list[index]);
                  ForecastAPI.getData(
                      forecastProvider, historyProivder.history_list[index]);
                  close(context, null);
                },
                title: Text(
                  historyProivder.getHistory[index],
                  style: TextStyle(
                    color: blackCon,
                    fontSize: 18,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: blackCon,
                    size: 22,
                  ),
                  onPressed: () {
                    historyProivder.removeItem(index);
                  },
                ),
                leading: Icon(
                  Icons.history,
                  color: blackCon,
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  WeatherProvider weatherProvider =
                      Provider.of<WeatherProvider>(context, listen: false);
                  ForecastProvider forecastProvider =
                      Provider.of<ForecastProvider>(context, listen: false);
                  weatherProvider.setIsLoaded(false);
                  forecastProvider.setIsLoaded(false);
                  WeatherAPI.getData(weatherProvider, matchQuery[index]);
                  ForecastAPI.getData(forecastProvider, matchQuery[index]);
                  historyProivder.addItemInHistory(matchQuery[index]);
                  print(matchQuery[index]);
                  close(context, null);
                },
                title: Text(
                  matchQuery[index],
                  style: TextStyle(
                    color: blackCon,
                    fontSize: 18,
                  ),
                ),
                leading: Icon(
                  Icons.location_city,
                  color: blackCon,
                ),
              );
            },
          );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: blackCon.withOpacity(0.7),
        elevation: 0,
      ),
      scaffoldBackgroundColor: whiteCon,
      inputDecorationTheme: searchFieldDecorationTheme,
    );
  }

  @override
  TextStyle? get searchFieldStyle {
    return TextStyle(color: whiteCon, fontSize: 22);
  }

  @override
  InputDecorationTheme? get searchFieldDecorationTheme {
    return InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        color: whiteCon,
      ),
    );
  }
}
