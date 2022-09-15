import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/forecast_provider.dart';
import 'package:weather_app/services/api_call_forecast.dart';
import 'package:weather_app/utility/constants.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/services/api_call_weather.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';

import '../utility/countries.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final date = DateTime.now();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      WeatherProvider provider =
          Provider.of<WeatherProvider>(context, listen: false);
      ForecastProvider forecastProvider =
          Provider.of<ForecastProvider>(context, listen: false);
      getData(provider, forecastProvider);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getData(
      WeatherProvider provider, ForecastProvider forecastProvider) async {
    await WeatherAPI.getData(provider, "Mumbai");
    await ForecastAPI.getData(forecastProvider, "Mumbai");
  }

  @override
  Widget build(BuildContext context) {
    WeatherProvider provider = Provider.of<WeatherProvider>(context);
    ForecastProvider forecastProvider = Provider.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Visibility(
        visible: provider.dataIsLoaded,
        replacement: Center(
          child: Lottie.asset("lib/assets/loading/loading.json"),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomAppBar(),
            SizedBox(
              height: height / (10 * pi),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(12),
              height: height / 2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primeColor,
                borderRadius: BorderRadius.circular(width / (5 * pi)),
                border: Border.all(
                  width: 2,
                  color: secondColor,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "${provider.getTemp()}\n",
                          style: TextStyle(
                            fontSize: 88,
                            fontWeight: FontWeight.bold,
                            color: whiteCon,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: provider.getMain ?? " ",
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.asset(
                            "lib/assets/icons/${provider.getIcon}.png"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / (pi * 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        size: 26,
                        color: whiteCon,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "${provider.getCity()},",
                        style: TextStyle(
                          color: whiteCon,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          " ${countries[provider.getCountry]} ",
                          style: TextStyle(
                            color: whiteCon,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${getWeekDay(date.weekday.toString())}",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        ",",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        date.day.toString(),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        " ${getMonth(date.month.toString())}",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / (10 * pi),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MYC(
                        content: "${provider.speed} km/h",
                        icon: Icon(
                          Icons.air_rounded,
                          color: whiteCon,
                        ),
                        width: width,
                        height: height,
                        text: "Wind",
                      ),
                      MYC(
                        content: "${provider.getHumidity}%",
                        icon: Icon(
                          Icons.water_drop_rounded,
                          color: whiteCon,
                        ),
                        text: "Humidity",
                        width: width,
                        height: height,
                      ),
                      MYC(
                        content: "${provider.pressure} hPa",
                        icon: SizedBox(
                          height: 25,
                          width: 25,
                          child: Image.asset(
                            "lib/assets/icons/pressure.png",
                            color: whiteCon,
                          ),
                        ),
                        text: "Pressure",
                        width: width,
                        height: height,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: height / (15 * pi),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: height / 5,
                  width: width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: forecastProvider.getForecastLength,
                    itemBuilder: (BuildContext context, int index) {
                      return MyContainer(
                        index: index,
                        provider: forecastProvider,
                        hight: height,
                        width: width,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MYC extends StatelessWidget {
  Widget icon;
  String content;
  String text;
  double height;
  double width;
  MYC(
      {required this.content,
      required this.icon,
      required this.text,
      required this.height,
      required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: height / 6,
      width: width / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: secondColor,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Text(
            content,
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            text,
            style: TextStyle(color: whiteCon, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

String? getWeekDay(String number) {
  Map<String, String> weekDay = {
    "1": "Monday",
    "2": "Tuesday",
    "3": "Wednesday",
    "4": "Thursday",
    "5": "Friday",
    "6": "Saturday",
    "7": "Sunday"
  };

  return weekDay[number];
}

String? getMonth(String number) {
  Map<String, String> month = {
    "1": "January",
    "2": "February",
    "3": "March",
    "4": "April",
    "5": "May",
    "6": "June",
    "7": "July",
    "8": "August",
    "9": "September",
    "10": "October",
    "11": "November",
    "12": "December",
  };

  return month[number];
}

class MyContainer extends StatelessWidget {
  double hight;
  double width;
  ForecastProvider provider;
  int index;
  MyContainer(
      {Key? key,
      required this.hight,
      required this.width,
      required this.index,
      required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      width: width / 3,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: secondColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          "${provider.getForecastList[index].main.temp}",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
