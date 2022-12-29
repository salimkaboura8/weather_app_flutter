import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/weather_forecast_data.dart';
import '../data/weather_forecast_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cityName = "";
  Network network = Network();
  Future<WeatherForecastModel>? forecast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 400.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: "Enter City Name",
                      border: InputBorder.none),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120, right: 120, bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    forecast = network.getWeatherForecast(cityName: cityName);
                  });
                },
                child: Text("Get Weather"),
              ),
            ),
            FutureBuilder(
              future: forecast,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  //get weather information
                  var weatherData = snapshot.data;

                  String formattedDate = DateFormat('EEEE, MMM d, ' 'yyyy')
                      .format(weatherData.date);

                  //get the weather icons
                  String icon = getIconFromWeatherId(weatherData.id);

                  List<String> nextIcons = [
                    getIconFromWeatherId(weatherData.next3days[0].id),
                    getIconFromWeatherId(weatherData.next3days[1].id),
                    getIconFromWeatherId(weatherData.next3days[2].id)
                  ];

                  List<String> nextDates = [
                    DateFormat('EEEE').format(weatherData.next3days[0].date),
                    DateFormat('EEEE').format(weatherData.next3days[1].date),
                    DateFormat('EEEE').format(weatherData.next3days[2].date),
                  ];

                  print(
                      'one is ${weatherData.next3days[0].date} ${weatherData.next3days[1].date}');

                  double temp = weatherData.temp;
                  String desc = weatherData.weatherDescription;
                  double speed = weatherData.windSpeed;
                  int humidity = weatherData.humidity;
                  String cityCountry =
                      weatherData.city + ", " + weatherData.country;

                  //get the 3 upcoming days
                  //List forecasts = list.sublist(0, 3);

                  return Column(
                    children: <Widget>[
                      Text(
                        cityCountry,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(formattedDate),
                      Image.asset(
                        'assets/$icon',
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        '${temp.round()} °C',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        '$desc',
                        style: TextStyle(fontSize: 22),
                      ),
                      Text('Wind Speed: $speed mi/h'),
                      Text('Humidity: $humidity %'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('3 Day Forecast:'),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 108,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.lightBlueAccent,
                                            Colors.white60
                                          ]),
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${weatherData.next3days[index].tempMin}',
                                        style: const TextStyle(
                                          fontSize: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(nextDates[index]),
                                      Text(
                                          '${(weatherData.next3days[index].tempMin).round()} °C'),
                                      Text(
                                          '${weatherData.next3days[index].windSpeed} mi/h'),
                                      Text(
                                          'Humidity: ${weatherData.next3days[index].humidity}%'),
                                      Image.asset(
                                        'assets/' + nextIcons[index],
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  );
                } else {
                  print(snapshot.toString());
                  return Text(
                    'Please enter a City name',
                    textAlign: TextAlign.center,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  String getIconFromWeatherId(id) {
    String icon = "";
    if (id == 800) {
      icon = 'sunny.png';
    } else if (id >= 801 && id <= 804) {
      icon = 'cloud.png';
    } else if (id >= 500 && id <= 531) {
      icon = 'rain.png';
    } else {
      icon = 'cloud.png';
    }
    return icon;
  }
}
