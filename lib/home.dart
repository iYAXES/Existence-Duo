import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_and_weather_app/provider_test.dart';
import 'package:world_and_weather_app/weather/weatherHome.dart';
import 'package:world_and_weather_app/world_time/loadingscreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  List screens = [WeatherHome(), LoadingScreen2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Existence Duo',
          style: TextStyle(
            fontFamily: 'Howvetical',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              icon: Icon(
                Icons.nightlight,
                size: 24,
                color: Theme.of(context).colorScheme.onPrimary,
              ))
        ],
      ),
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            height: 55,
            labelTextStyle: MaterialStatePropertyAll(TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
          ),
          child: NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (index) {
                setState(() {
                  this.index = index;
                });
              },
              backgroundColor: Theme.of(context).colorScheme.background,
              indicatorColor: Colors.grey[200],
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.cloud, color: Colors.white),
                  selectedIcon: Icon(
                    Icons.cloud,
                    color: Colors.black,
                  ),
                  label: 'Weather',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.access_time_filled,
                    size: 25,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  label: 'WorldTime',
                  selectedIcon: Icon(
                    Icons.access_time_filled,
                    color: Colors.black,
                  ),
                )
              ])),
    );
  }
}
