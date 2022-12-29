import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/business_logic/weather_forecast_cubit.dart';
import 'package:weather_app/presentation/weather_forecast_screen.dart';

import 'data/weather_forecast_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => WeatherForecastCubit(
          WeatherForecastRepository(),
        ),
        child: MyHomePage(
          title: 'Weather App',
        ),
      ),
    );
  }
}
