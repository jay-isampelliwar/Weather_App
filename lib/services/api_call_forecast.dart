import 'package:http/http.dart' as http;
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/provider/forecast_provider.dart';

class ForecastAPI {
  static Future<void> getData(ForecastProvider provider, String city) async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&cnt=14&appid=87e36f98092a2cafea2428b8efcf42f8&units=metric");

    var res = await client.get(uri);

    if (res.statusCode == 200) {
      Forecast forecast = forecastFromJson(res.body);
      int len = forecast.list.length;
      provider.setList(forecast.list);
      if (forecast != null) {
      } else {
        throw "E R R O R";
      }
    }
  }
}
