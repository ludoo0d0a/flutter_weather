import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/commons/bloc_delegate.dart';
import 'package:flutter_weather/repositories/weather_repository.dart';
import 'package:flutter_weather/widgets/weather.dart';

import 'package:flutter_weather/widgets/widgets.dart';

import 'repositories/weather_api_client.dart';
import 'package:http/http.dart' as http;

void main() {
  //
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      home: Weather(
        weatherRepository: weatherRepository,
      ),
    );
  }
}