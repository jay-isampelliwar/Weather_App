import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/forecast_provider.dart';
import 'package:weather_app/services/api_call_forecast.dart';
import 'package:weather_app/utility/constants.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/services/api_call_weather.dart';
import 'package:weather_app/widgets/custom_app_bar.dart';
import 'package:weather_app/widgets/loading_widget.dart';

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
        replacement: const Center(
          child: LoadingWidget(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomAppBar(),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(10),
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                            color: blackCon,
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
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        size: 26,
                        color: blackCon,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${provider.getCity()},",
                        style: TextStyle(
                          color: blackCon,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          " ${countries[provider.getCountry]} ",
                          style: TextStyle(
                            color: blackCon,
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
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MYC(
                        content: "${provider.speed} km/h",
                        icon: Icon(
                          Icons.air_rounded,
                          color: blackCon,
                        ),
                        width: width,
                        height: height,
                        text: "Wind",
                      ),
                      MYC(
                        content: "${provider.getHumidity}%",
                        icon: Icon(
                          Icons.water_drop_rounded,
                          color: blackCon,
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
                            color: blackCon,
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
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: forecastProvider.isLoaded
                      ? GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: forecastProvider.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: ((context, index) {
                            return MyContainer(
                              hight: height,
                              width: width,
                              index: index,
                              provider: forecastProvider,
                            );
                          }),
                        )
                      : const Center(
                          child: LoadingWidget(),
                        )),
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
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
            style: TextStyle(color: blackCon, fontSize: 18),
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
      height: 200,
      width: 200,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            dateFormate(provider, index),
            style: TextStyle(color: blackCon, fontWeight: FontWeight.bold),
          ),
          Text(
            timeFormate(provider, index),
            style: TextStyle(color: blackCon, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          SizedBox(
            height: 80,
            width: 80,
            child: Image.asset('lib/assets/icons/${provider.icons[index]}'),
          ),
          const Spacer(),
          Text(
            "${provider.forecastList[index].main.temp}",
            style: TextStyle(
                color: blackCon, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String dateFormate(ForecastProvider provider, int index) {
    String? day = provider.forecastList[index].dtTxt.day.toString();
    String? month =
        getMonth(provider.forecastList[index].dtTxt.month.toString());

    String hour = provider.forecastList[index].dtTxt.hour.toString();

    return "$day ${month!}";
  }

  String timeFormate(ForecastProvider provider, int index) {
    String hour = provider.forecastList[index].dtTxt.hour.toString();

    return hour.length == 1 ? "0$hour:00" : "$hour:00";
  }
}
