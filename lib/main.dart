import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_and_weather_app/Test_Tuesday/homepage.dart';
import 'package:world_and_weather_app/Test_Tuesday/models/loading.dart';
import 'package:world_and_weather_app/home.dart';
import 'package:world_and_weather_app/provider_test.dart';
import 'package:world_and_weather_app/tes/test_thurdday.dart';
import 'package:world_and_weather_app/tes/thome.dart';
import 'package:world_and_weather_app/tes/tloading.dart';
import 'package:world_and_weather_app/tes/tlocation.dart';

import 'package:world_and_weather_app/weather/chooselocation.dart';
import 'package:world_and_weather_app/weather/chooselocationTest.dart';
import 'package:world_and_weather_app/weather/forcast.dart';
import 'package:world_and_weather_app/weather/loading.dart';
import 'package:world_and_weather_app/weather/weatherHome.dart';
import 'package:world_and_weather_app/world_time/loadingscreen.dart';
import 'package:world_and_weather_app/world_time/locations.dart';
import 'package:world_and_weather_app/world_time/wtimeHome.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

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
        '/locations': (context) => ChooseLocation2(),

        '/weatherlocation': (context) => ChooseLocation(),
        '/weatherhome': (context) => WeatherHome(),
        '/forcast': (context) => Forcast(),
        '/clock': (context) => Clock(),
        //TESTING ROUTES HERE
        // '/': (context) => TlaodingScreen(),
        //'/thomescreen': (context) => Thomepage(),
      },
    );
  }
}
