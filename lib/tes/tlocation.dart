import 'package:flutter/material.dart';
import 'package:world_and_weather_app/tes/tweather_services.dart';

class tLocations extends StatefulWidget {
  const tLocations({super.key});

  @override
  State<tLocations> createState() => _tLocationsState();
}

class _tLocationsState extends State<tLocations> {
  tWeatherServices _weatherServices = tWeatherServices();
  List forecastHour = [];
  List<String> tlocations = [];
  void getLocation() {
    tlocations = [
      'NewYork, USA',
      'London, UK',
      'Paris France',
      'Tokyo, Japan',
      'Los Angeles, USA',
      'Hong Kong, China',
      'Dubai, UAE',
      'Singapore',
      'Sydney, Australia',
      'Rome, Italy',
      'Barcelona, Spain',
      'Berlin, Germany',
      'Istanbul, Turkey',
      'Bangkok, Thailand',
      'Moscow, Russia',
      'Mumbai, India',
      'Beijing, China',
      'Shanghai, China',
      'Toronto, Canada',
      'Sao Paulo, Brazil',
    ];

    List<String> formatLoca =
        tlocations.map((loca) => formatShow(loca)).toList();
    formatLoca.sort((a, b) => a.compareTo(b));

    setState(() {
      tlocations = formatLoca;
    });
  }

  String formatShow(String locationName) {
    List<String> split = locationName.split(',');
    return split.isNotEmpty ? split.first.replaceAll(' ', '-') : locationName;
  }

  void tupdateWeda(String tupdate) async {
    tWeather weda = await _weatherServices.gettWeatherData(tupdate);

    forecastHour = weda.forecastHour;
    Navigator.pop(context, {
      'location': weda.location,
      'temperature': weda.temperatureC,
      'condition': weda.condition,
      'forecastHour': forecastHour,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Choose Locations'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: tCustomSearchDelegate(
                        tlocations: tlocations, tupdateWeda: tupdateWeda));
              },
              icon: Icon(Icons.search))
        ],
      ),
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: tlocations.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.transparent,
                margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                elevation: 0,
                child: ListTile(
                  title: Text('${tlocations[index]}'),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    tupdateWeda(tlocations[index]);
                  },
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}

class tCustomSearchDelegate extends SearchDelegate {
  final List<String> tlocations;
  final Function(String) tupdateWeda;
  tCustomSearchDelegate({required this.tlocations, required this.tupdateWeda});

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
        icon: Icon(Icons.arrow_back_ios_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    var matchQuery = [];
    for (var location in tlocations) {
      if (location.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(location);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var results = matchQuery[index];
        return Card(
          color: Colors.transparent,
          elevation: 0,
          child: ListTile(
            title: Text(results),
            onTap: () {
              tupdateWeda(results);
              close(context, null);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var matchQuery = [];
    for (var location in tlocations) {
      if (location.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(location);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var results = matchQuery[index];
        return Card(
          color: Colors.transparent,
          elevation: 0,
          child: ListTile(
            title: Text(results),
            onTap: () {
              tupdateWeda(results);
              close(context, null);
            },
          ),
        );
      },
    );
  }
}
