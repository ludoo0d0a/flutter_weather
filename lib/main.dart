import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/commons/bloc_delegate.dart';
import 'package:flutter_weather/repositories/weather_repository.dart';
import 'package:flutter_weather/widgets/weather.dart';

import 'package:flutter_weather/widgets/widgets.dart';
import 'package:flutter_weather/theme/theme.dart';

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

class App extends StatefulWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeBloc _themeBloc = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _themeBloc,
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeState themeState) {
          return MaterialApp(
            title: 'Flutter Weather',
            theme: themeState.theme,
            home: Weather(
              weatherRepository: widget.weatherRepository,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    super.dispose();
  }
}
