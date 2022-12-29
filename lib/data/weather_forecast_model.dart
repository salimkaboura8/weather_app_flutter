import 'forecast_model.dart';

class WeatherForecastModel {
  // Properties
  int id;
  double temp;
  int pressure;
  int humidity;
  String weatherDescription;
  double windSpeed;
  String city;
  String country;
  DateTime date;
  List<Forecast> next3days;

  // Constructor
  WeatherForecastModel({
    required this.id,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.weatherDescription,
    required this.windSpeed,
    required this.city,
    required this.country,
    required this.date,
    required this.next3days,
  });

  static Future<WeatherForecastModel> fromJson(decode) {
    final jsonData = decode;

    return Future.value(WeatherForecastModel(
      id: jsonData['list'][0]['weather'][0]['id'],
      temp: jsonData['list'][0]['main']['temp'] - 273.15,
      pressure: jsonData['list'][0]['main']['pressure'],
      humidity: jsonData['list'][0]['main']['humidity'],
      windSpeed: jsonData['list'][0]['wind']['speed'],
      weatherDescription: jsonData['list'][0]['weather'][0]['description'],
      city: jsonData['city']['name'],
      country: jsonData['city']['country'],
      date:
          DateTime.fromMillisecondsSinceEpoch(jsonData['list'][0]['dt'] * 1000),
      next3days: [
        Forecast(
            jsonData['list'][8]['weather'][0]['id'],
            DateTime.fromMillisecondsSinceEpoch(
                jsonData['list'][8]['dt'] * 1000),
            jsonData['list'][8]['main']['temp_min'] - 273.15,
            jsonData['list'][8]['main']['temp_max'] - 273.15,
            jsonData['list'][8]['main']['humidity'],
            jsonData['list'][8]['wind']['speed'].toDouble()),
        Forecast(
            jsonData['list'][16]['weather'][0]['id'],
            DateTime.fromMillisecondsSinceEpoch(
                jsonData['list'][16]['dt'] * 1000),
            jsonData['list'][16]['main']['temp_min'] - 273.15,
            jsonData['list'][16]['main']['temp_max'] - 273.15,
            jsonData['list'][16]['main']['humidity'],
            jsonData['list'][16]['wind']['speed'].toDouble()),
        Forecast(
            jsonData['list'][24]['weather'][0]['id'],
            DateTime.fromMillisecondsSinceEpoch(
                jsonData['list'][24]['dt'] * 1000),
            jsonData['list'][24]['main']['temp_min'] - 273.15,
            jsonData['list'][24]['main']['temp_max'] - 273.15,
            jsonData['list'][24]['main']['humidity'],
            jsonData['list'][24]['wind']['speed'].toDouble())
      ],
    ));
  }
}
