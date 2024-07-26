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
    LocationName(name: 'Akure'),
    LocationName(name: 'Abuja'),
    LocationName(name: ' Abu Dhabi  '),
    LocationName(name: ' Amsterdam  '),
    LocationName(name: ' Ankara  '),
    LocationName(name: ' Athens  '),
    LocationName(name: ' Atlanta  '),
    LocationName(name: ' Auckland  '),
    LocationName(name: ' Baghdad  '),
    LocationName(name: 'Baltimore'),
    LocationName(name: ' Bangkok  '),
    LocationName(name: ' Barcelona  '),
    LocationName(name: ' Beijing  '),
    LocationName(name: ' Beirut  '),
    LocationName(name: ' Berlin  '),
    LocationName(name: ' Bogota  '),
    LocationName(name: ' Boston  '),
    LocationName(name: ' Brasilia  '),
    LocationName(name: ' Brussels  '),
    LocationName(name: ' Buenos Aires  '),
    LocationName(name: ' Cairo  '),
    LocationName(name: ' Cape Town  '),
    LocationName(name: ' Caracas  '),
    LocationName(name: ' Chicago  '),
    LocationName(name: ' Copenhagen  '),
    LocationName(name: ' Dallas  '),
    LocationName(name: ' Damascus  '),
    LocationName(name: ' Casablanca  '),
    LocationName(name: ' Delhi  '),
    LocationName(name: ' Dhaka  '),
    LocationName(name: ' Dubai  '),
    LocationName(name: ' Dublin  '),
    LocationName(name: ' Edinburgh  '),
    LocationName(name: ' Frankfurt  '),
    LocationName(name: ' Geneva  '),
    LocationName(name: ' Guangzhou  '),
    LocationName(name: ' Havana  '),
    LocationName(name: ' Helsinki  '),
    LocationName(name: ' Hong Kong  '),
    LocationName(name: ' Houston  '),
    LocationName(name: ' Istanbul  '),
    LocationName(name: ' Jakarta  '),
    LocationName(name: ' Johannesburg  '),
    LocationName(name: ' Karachi  '),
    LocationName(name: ' Kathmandu  '),
    LocationName(name: ' Khartoum  '),
    LocationName(name: ' Kinshasa  '),
    LocationName(name: ' Kuala Lumpur  '),
    LocationName(name: ' Lagos  '),
    LocationName(name: ' Lima  '),
    LocationName(name: ' Lisbon  '),
    LocationName(name: ' London  '),
    LocationName(name: ' Los Angeles  '),
    LocationName(name: ' Madrid  '),
    LocationName(name: ' Manila  '),
    LocationName(name: ' Mexico City  '),
    LocationName(name: ' Miami  '),
    LocationName(name: ' Milan  '),
    LocationName(name: ' Montreal  '),
    LocationName(name: ' Moscow  '),
    LocationName(name: ' Mumbai  '),
    LocationName(name: ' Nairobi  '),
    LocationName(name: ' New Delhi  '),
    LocationName(name: ' New York  '),
    LocationName(name: ' Osaka  '),
    LocationName(name: ' Oslo  '),
    LocationName(name: ' Paris  '),
    LocationName(name: ' Perth  '),
    LocationName(name: ' Prague  '),
    LocationName(name: ' Quito  '),
    LocationName(name: ' Riyadh  '),
    LocationName(name: ' Rome  '),
    LocationName(name: ' San Francisco  '),
    LocationName(name: ' Santiago  '),
    LocationName(name: ' Sao Paulo  '),
    LocationName(name: ' Seoul  '),
    LocationName(name: ' Shanghai  '),
    LocationName(name: ' Singapore  '),
    LocationName(name: ' Stockholm  '),
    LocationName(name: ' Sydney  '),
    LocationName(name: ' Taipei  '),
    LocationName(name: ' Tehran  '),
    LocationName(name: ' Tel Aviv  '),
    LocationName(name: ' Tokyo  '),
    LocationName(name: ' Toronto  '),
    LocationName(name: ' Vancouver  '),
    LocationName(name: ' Vienna  '),
    LocationName(name: ' Warsaw  '),
    LocationName(name: ' Washington, D.C.  '),
    LocationName(name: ' Wellington  '),
    LocationName(name: ' Yangon  '),
  ];

  void updateWeather(String locationName) async {
    Weather updateWeda = await weatherServices.getWeatherData(locationName);

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
        leading: SizedBox(),
        title: Text(
          'Select City',
          style: TextStyle(fontFamily: 'Montserrat bold'),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate:
                        CustomSearchDelegate2(updateWeather: updateWeather));
              },
              icon: Icon(Icons.search))
        ],
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
                updateWeather(locations[index].name);
              },
            ),
          );
        },
      ),
    );
  }
}

class CustomSearchDelegate2 extends SearchDelegate {
  final Function(String) updateWeather;

  CustomSearchDelegate2({required this.updateWeather});

  List<LocationName> locations = [
    LocationName(name: 'Akure'),
    LocationName(name: 'Abuja'),
    LocationName(name: ' Abu Dhabi  '),
    LocationName(name: ' Amsterdam  '),
    LocationName(name: ' Ankara  '),
    LocationName(name: ' Athens  '),
    LocationName(name: ' Atlanta  '),
    LocationName(name: ' Auckland  '),
    LocationName(name: ' Baghdad  '),
    LocationName(name: 'Baltimore'),
    LocationName(name: ' Bangkok  '),
    LocationName(name: ' Barcelona  '),
    LocationName(name: ' Beijing  '),
    LocationName(name: ' Beirut  '),
    LocationName(name: ' Berlin  '),
    LocationName(name: ' Bogota  '),
    LocationName(name: ' Boston  '),
    LocationName(name: ' Brasilia  '),
    LocationName(name: ' Brussels  '),
    LocationName(name: ' Buenos Aires  '),
    LocationName(name: ' Cairo  '),
    LocationName(name: ' Cape Town  '),
    LocationName(name: ' Caracas  '),
    LocationName(name: ' Chicago  '),
    LocationName(name: ' Copenhagen  '),
    LocationName(name: ' Dallas  '),
    LocationName(name: ' Damascus  '),
    LocationName(name: ' Casablanca  '),
    LocationName(name: ' Delhi  '),
    LocationName(name: ' Dhaka  '),
    LocationName(name: ' Dubai  '),
    LocationName(name: ' Dublin  '),
    LocationName(name: ' Edinburgh  '),
    LocationName(name: ' Frankfurt  '),
    LocationName(name: ' Geneva  '),
    LocationName(name: ' Guangzhou  '),
    LocationName(name: ' Havana  '),
    LocationName(name: ' Helsinki  '),
    LocationName(name: ' Hong Kong  '),
    LocationName(name: ' Houston  '),
    LocationName(name: ' Istanbul  '),
    LocationName(name: ' Jakarta  '),
    LocationName(name: ' Johannesburg  '),
    LocationName(name: ' Karachi  '),
    LocationName(name: ' Kathmandu  '),
    LocationName(name: ' Khartoum  '),
    LocationName(name: ' Kinshasa  '),
    LocationName(name: ' Kuala Lumpur  '),
    LocationName(name: ' Lagos  '),
    LocationName(name: ' Lima  '),
    LocationName(name: ' Lisbon  '),
    LocationName(name: ' London  '),
    LocationName(name: ' Los Angeles  '),
    LocationName(name: ' Madrid  '),
    LocationName(name: ' Manila  '),
    LocationName(name: ' Mexico City  '),
    LocationName(name: ' Miami  '),
    LocationName(name: ' Milan  '),
    LocationName(name: ' Montreal  '),
    LocationName(name: ' Moscow  '),
    LocationName(name: ' Mumbai  '),
    LocationName(name: ' Nairobi  '),
    LocationName(name: ' New Delhi  '),
    LocationName(name: ' New York  '),
    LocationName(name: ' Osaka  '),
    LocationName(name: ' Oslo  '),
    LocationName(name: ' Paris  '),
    LocationName(name: ' Perth  '),
    LocationName(name: ' Prague  '),
    LocationName(name: ' Quito  '),
    LocationName(name: ' Riyadh  '),
    LocationName(name: ' Rome  '),
    LocationName(name: ' San Francisco  '),
    LocationName(name: ' Santiago  '),
    LocationName(name: ' Sao Paulo  '),
    LocationName(name: ' Seoul  '),
    LocationName(name: ' Shanghai  '),
    LocationName(name: ' Singapore  '),
    LocationName(name: ' Stockholm  '),
    LocationName(name: ' Sydney  '),
    LocationName(name: ' Taipei  '),
    LocationName(name: ' Tehran  '),
    LocationName(name: ' Tel Aviv  '),
    LocationName(name: ' Tokyo  '),
    LocationName(name: ' Toronto  '),
    LocationName(name: ' Vancouver  '),
    LocationName(name: ' Vienna  '),
    LocationName(name: ' Warsaw  '),
    LocationName(name: ' Washington, D.C.  '),
    LocationName(name: ' Wellington  '),
    LocationName(name: ' Yangon  '),
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var location in locations) {
      if (location.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(location.name);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Card(
          shape: BorderDirectional(
            bottom:
                BorderSide(color: Theme.of(context).colorScheme.onSecondary),
          ),
          elevation: 0,
          color: Theme.of(context).colorScheme.onSecondary,
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
          child: ListTile(
            title: Text(
              result,
              style: TextStyle(fontFamily: 'Montserrat bold'),
            ),
            onTap: () {
              updateWeather(result);
              close(context, null);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var location in locations) {
      if (location.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(location.name);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Card(
          shape: BorderDirectional(
            bottom:
                BorderSide(color: Theme.of(context).colorScheme.onSecondary),
          ),
          elevation: 0,
          color: Theme.of(context).colorScheme.onSecondary,
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
          child: ListTile(
            onTap: () {
              updateWeather(result);
              close(context, null);
            },
            title: Text(
              result,
              style: TextStyle(fontFamily: 'Montserrat bold'),
            ),
          ),
        );
      },
    );
  }
}
