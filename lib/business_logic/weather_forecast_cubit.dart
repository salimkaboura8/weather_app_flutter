import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../data/weather_forecast_data.dart';
import '../data/weather_forecast_model.dart';

part '../presentation/weather_forecast_state.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  final WeatherForecastRepository _repository;

  WeatherForecastCubit(this._repository) : super(WeatherForecastInitial());

  void fetchWeatherForecast(String city) async {
    emit(WeatherForecastLoading());
    try {
      final weatherForecast = await _repository.fetchWeatherForecast(city);
      emit(WeatherForecastLoaded(weatherForecast));
    } catch (error) {
      emit(WeatherForecastError(error.toString()));
    }
  }
}
