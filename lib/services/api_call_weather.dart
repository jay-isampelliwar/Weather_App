import 'package:http/http.dart' as http;
import '../model/weather_model.dart';
import '../provider/weather_provider.dart';

class WeatherAPI {
  static Future<void> getData(WeatherProvider? provider, String city) async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=87e36f98092a2cafea2428b8efcf42f8&units=metric");

    var res = await client.get(uri);

    if (res.statusCode == 200) {
      WeatherModel weatherModel = weatherModelFromJson(res.body);
      if (weatherModel != null) {
        setData(provider, weatherModel, city);
      } else {
        throw "E R R O R";
      }
    }
  }

  static setData(var weatherProvider, var weatherModel, String city) {
    weatherProvider.setTemp(weatherModel!.main.temp);
    weatherProvider.setCity(city);
    weatherProvider.setFeelsLike(weatherModel!.main.feelsLike);
    weatherProvider.setHumidity(weatherModel!.main.humidity);
    weatherProvider.setId(weatherModel!.weather.first.id);
    weatherProvider.setIcon(weatherModel!.weather.first.icon);
    weatherProvider.setDescription(weatherModel!.weather.first.description);
    weatherProvider.setSpeed(weatherModel!.wind.speed);
    weatherProvider.setMain(weatherModel!.weather.first.main);
    weatherProvider.setCountry(weatherModel!.sys.country);
    weatherProvider.setPressure(weatherModel!.main.pressure);
    weatherProvider.setIsLoaded(true);
    // print(weatherProvider.getIcon);
  }
}
