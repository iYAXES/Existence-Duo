import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_and_weather_app/tes/tweather_services.dart';

class tWeatherLoading extends StatefulWidget {
  const tWeatherLoading({super.key});

  @override
  State<tWeatherLoading> createState() => _tWeatherLoadingState();
}

class _tWeatherLoadingState extends State<tWeatherLoading> {
  tWeatherServices tweatherServices = tWeatherServices();
  List forecastHour = [];

  void tLoadWeather() async {
    tWeather weather = await tweatherServices.gettWeatherData('Lagos');

    setState(() {
      forecastHour = weather.forecastHour;
    });

    Navigator.pushReplacementNamed(context, '/thome', arguments: {
      'location': weather.location,
      'condition': weather.condition,
      'temperature': weather.temperatureC,
      'forecastHour': forecastHour,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tLoadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SpinKitFadingCircle(
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
