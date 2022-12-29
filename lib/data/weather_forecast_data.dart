import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/data/weather_forecast_model.dart';

class WeatherForecastRepository {
  final Network _network = Network();

  WeatherForecastRepository();

  Future<WeatherForecastModel> fetchWeatherForecast(String city) async {
    try {
      final weatherForecastModel =
          await _network.getWeatherForecast(cityName: city);
      return weatherForecastModel;
    } catch (error) {
      throw Exception('Failed to fetch weather forecast');
    }
  }
}

class Network {
  Future<WeatherForecastModel> getWeatherForecast(
      {required String cityName}) async {
    var finalUrl = "https://api.openweathermap.org/data/2.5/forecast?q=" +
        cityName +
        "&appid=421091f8d69eafc46edab74dbaed97bd";

    final response = await get(Uri.parse(finalUrl));
    print("URL: ${Uri.encodeFull(finalUrl)}");

    if (response.statusCode == 200) {
      //print("weather data: ${response.body}");
      print(json.decode(response.body));

      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting weather forecast");
    }
  }
}
