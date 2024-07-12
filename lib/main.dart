import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_and_weather_app/home.dart';
import 'package:world_and_weather_app/provider_test.dart';
import 'package:world_and_weather_app/weather/chooselocation.dart';
import 'package:world_and_weather_app/weather/forcast.dart';
import 'package:world_and_weather_app/weather/loading.dart';
import 'package:world_and_weather_app/weather/weatherHome.dart';
import 'package:world_and_weather_app/world_time/wtimeHome.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/worldtime': (context) => WorldTimeHome(),
        '/locations': (context) => ChooseLocation(),
        '/weatherlocation': (context) => ChooseLocation(),
        '/weatherhome': (context) => WeatherHome(),
        '/forcast': (context) => Forcast(),
        '/clock': (context) => Clock(),
      },
    );
  }
}
