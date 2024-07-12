import 'package:flutter/material.dart';
import 'package:world_and_weather_app/weather/weatherService.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  WeatherServices weatherServices = WeatherServices();
  List getHour = [];
  List getDay = [];
  List<LocationName> locations = [
    LocationName(name: 'Lagos'),
    LocationName(name: 'Abuja'),
    LocationName(name: 'Australia'),
    LocationName(name: 'Baltimore'),
    LocationName(name: 'Canada'),
    LocationName(name: 'China'),
    LocationName(name: 'Cuba'),
    LocationName(name: 'Germany'),
    LocationName(name: 'Haiti'),
    LocationName(name: 'Italy'),
    LocationName(name: 'korea'),
    LocationName(name: 'London'),
    LocationName(name: 'South Africa'),
    LocationName(name: 'Texas'),
    LocationName(name: 'Turkey'),
  ];

  void updateWeather(index) async {
    Weather updateWeda =
        await weatherServices.getWeatherData('${locations[index].name}');

    getHour = updateWeda.forecasthour;
    getDay = updateWeda.forecastday;
    Navigator.pop(context, {
      'location': updateWeda.location,
      'condition': updateWeda.conditon,
      'tempC': updateWeda.temperatureC,
      'heatlevel': updateWeda.heatlevel,
      'cloudlevel': updateWeda.cloudlevel,
      'getHour': getHour,
      'getDay': getDay,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select City',
          style: TextStyle(fontFamily: 'Montserrat bold'),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 1,
      ),
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Card(
            shape: BorderDirectional(
              bottom:
                  BorderSide(color: Theme.of(context).colorScheme.onSecondary),
            ),
            elevation: 0,
            color: Theme.of(context).colorScheme.onSecondary,
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: ListTile(
              title: Text(
                '${locations[index].name}',
                style: TextStyle(
                  fontFamily: 'Howvetical',
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () {
                updateWeather(index);
              },
            ),
          );
        },
      ),
    );
  }
}
