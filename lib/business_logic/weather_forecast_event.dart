import 'package:flutter/material.dart';

abstract class WeatherForecastEvent {}

class WeatherForecastFetch extends WeatherForecastEvent {
  final String city;

  WeatherForecastFetch(@required this.city);
}
