import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/city_list.dart';
import 'package:weather_app/provider/history.dart';

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
            WeatherProvider provider =
                Provider.of<WeatherProvider>(context, listen: false);
            provider.setIsLoaded(false);
            WeatherAPI.getData(provider, matchQuery[index]);
            historyProivder.addItemInHistory(matchQuery[index]);
            close(context, null);
          },
          title: Text(
            matchQuery[index],
            style: TextStyle(
              color: whiteCon,
              fontSize: 18,
            ),
          ),
          leading: Icon(
            Icons.location_city,
            color: whiteCon,
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
                  WeatherProvider provider =
                      Provider.of<WeatherProvider>(context, listen: false);
                  provider.setIsLoaded(false);
                  WeatherAPI.getData(
                      provider, historyProivder.getHistory[index]);
                  close(context, null);
                },
                title: Text(
                  historyProivder.getHistory[index],
                  style: TextStyle(
                    color: whiteCon,
                    fontSize: 18,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: whiteCon,
                    size: 22,
                  ),
                  onPressed: () {
                    historyProivder.removeItem(index);
                  },
                ),
                leading: Icon(
                  Icons.history,
                  color: whiteCon,
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  WeatherProvider provider =
                      Provider.of<WeatherProvider>(context, listen: false);
                  provider.setIsLoaded(false);
                  WeatherAPI.getData(provider, matchQuery[index]);
                  historyProivder.addItemInHistory(matchQuery[index]);
                  // print(matchQuery[index]);
                  close(context, null);
                },
                title: Text(
                  matchQuery[index],
                  style: TextStyle(
                    color: whiteCon,
                    fontSize: 18,
                  ),
                ),
                leading: Icon(
                  Icons.location_city,
                  color: whiteCon,
                ),
              );
            },
          );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: primeColor,
        elevation: 0,
      ),
      scaffoldBackgroundColor: bgColor,
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
