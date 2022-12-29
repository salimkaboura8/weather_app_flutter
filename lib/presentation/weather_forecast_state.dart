part of '../business_logic/weather_forecast_cubit.dart';

abstract class WeatherForecastState {}

class WeatherForecastInitial extends WeatherForecastState {}

class WeatherForecastLoading extends WeatherForecastState {}

class WeatherForecastLoaded extends WeatherForecastState {
  final WeatherForecastModel weatherForecast;

  WeatherForecastLoaded(@required this.weatherForecast);
}

class WeatherForecastError extends WeatherForecastState {
  final String error;

  WeatherForecastError(@required this.error);
}
