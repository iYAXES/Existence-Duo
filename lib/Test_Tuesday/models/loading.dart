import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_and_weather_app/Test_Tuesday/services/Tweather_services.dart';
import 'package:intl/intl.dart';

class TlaodingScreen extends StatefulWidget {
  const TlaodingScreen({super.key});

  @override
  State<TlaodingScreen> createState() => _TlaodingScreenState();
}

class _TlaodingScreenState extends State<TlaodingScreen> {
  List forecastHour = [];
  TweatherServices tweatherServices = TweatherServices();

  void LoadTweather() async {
    Tweather currentWeather = await tweatherServices.getTweather('Lagos');
    setState(() {
      forecastHour = currentWeather.forecastHour;
    });
    // String formatCurrent = DateFormat.j().format(DateTime.now());
    DateTime nowTime = DateTime.now();
    bool isDayTime = nowTime.hour > 6 && nowTime.hour < 19 ? true : false;

    Navigator.pushReplacementNamed(context, '/thomescreen', arguments: {
      'location': currentWeather.location,
      'condition': currentWeather.condition,
      'icon': currentWeather.icon,
      'tempC': currentWeather.temperatureC,
      'tempF': currentWeather.temperatureF,
      'feelslikeC': currentWeather.feelslikeC,
      'forecastHour': forecastHour,
      'isDayTime': isDayTime
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadTweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 70,
        ),
      ),
    );
  }
}
