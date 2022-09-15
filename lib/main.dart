import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/forecast_provider.dart';
import 'package:weather_app/utility/constants.dart';
import 'package:weather_app/provider/city_list.dart';
import 'package:weather_app/provider/history.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => WeatherProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => History()),
        ),
        ChangeNotifierProvider(
          create: ((context) => CityList()),
        ),
        ChangeNotifierProvider(
          create: ((context) => ForecastProvider()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // useMaterial3: true,
        scaffoldBackgroundColor: bgColor,
        textTheme: TextTheme(
          headline2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: whiteCon,
          ),
          // headline2: GoogleFonts.bebasNeue(color: whiteCon),
        ),
        primarySwatch: Colors.grey,
      ),
      home: const HomePage(),
    );
  }
}
