import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_and_weather_app/weather/weatherService.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List getHour = [];
  List getDay = [];
  WeatherServices weatherServices = WeatherServices();

  void loadWeather() async {
    Weather weather = await weatherServices.getWeatherData('Lagos');
    setState(() {
      getHour = weather.forecasthour;
      getDay = weather.forecastday;
      //double forecastDay = getDay[0]['day']['maxtemp_c'];
    });
    //DateTime now = DateTime.now();
    //bool isDayTime = now.hour > 6 && now.hour < 19 ? true : false;

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': weather.location,
      'condition': weather.conditon,
      'tempC': weather.temperatureC,
      'heatlevel': weather.heatlevel,
      'cloudlevel': weather.cloudlevel,
      'getHour': getHour,
      'getDay': getDay,
      // 'isDayTime': isDayTime,
    });
  }

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }
}
