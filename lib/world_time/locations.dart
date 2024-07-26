import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:world_and_weather_app/world_time/worldtime.dart';
import 'dart:convert' as convert;

class ChooseLocation2 extends StatefulWidget {
  const ChooseLocation2({super.key});

  @override
  State<ChooseLocation2> createState() => _ChooseLocation2State();
}

class _ChooseLocation2State extends State<ChooseLocation2> {
  //List<String> locations = [];
  List<String> originalLocations = [];
  List<String> formattedLocations = [];

  Future<void> getAllzone() async {
    Response response =
        await get(Uri.parse('http://worldtimeapi.org/api/timezone'));
    List<String> zones = List<String>.from(convert.jsonDecode(response.body));

    //Format locations and Sort Aphalbetically
    List<String> formatedZones =
        zones.map((zone) => formatLocations(zone)).toList();
    formatedZones.sort((a, b) => a.compareTo(b));

    setState(() {
      originalLocations = zones;
      formattedLocations = formatedZones;
    });
  }

  Future<Map<String, dynamic>> getAlltime(String urls) async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$urls'));
      Map data = convert.jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      String time = DateFormat.jm().format(now);
      String weekDay = DateFormat('EEEE').format(now);
      dynamic clocktime = now;
      String day = DateFormat('d').format(now);
      String month = DateFormat.MMMM().format(now);
      String year = DateFormat.y().format(now);
      return {
        'time': time,
        'weekDay': weekDay,
        'clocktime': clocktime,
        'day': day,
        'month': month,
        'year': year,
      };
    } catch (e) {
      throw Exception('Unable to get Data from API $e');
    }
  }

  String formatLocations(String locationZone) {
    List<String> split = locationZone.split('/');
    return split.isNotEmpty ? split.last.replaceAll('_', ' ') : locationZone;
  }

  String getOriginalLocation(String formattedLocation) {
    return originalLocations
        .firstWhere((zone) => formatLocations(zone) == formattedLocation);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllzone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: Text(
          'Select Location',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate2(
                      formattedLocations: formattedLocations,
                      getOriginalLocations: getOriginalLocation,
                      getAlltime: getAlltime),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Container(
        // padding: EdgeInsets.fromLTRB(10, 80, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(color: Colors.grey, thickness: 1),
            Expanded(
              child: formattedLocations.isEmpty
                  ? Center(
                      child: SpinKitCircle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : ListView.builder(
                      itemCount: formattedLocations.length,
                      itemBuilder: (context, index) {
                        //Formating Location Name to Look User Friendly
                        String locationName = formattedLocations[index];
                        String originalLocation =
                            getOriginalLocation(locationName);
                        return FutureBuilder(
                          future: getAlltime(originalLocation),
                          builder: (BuildContext context,
                              AsyncSnapshot<Map<String, dynamic>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListTile(
                                title: Text('Loading...'),
                              );
                            } else {
                              String time = snapshot.data?['time'] ?? 'N/A';
                              String weekDay =
                                  snapshot.data?['weekDay'] ?? 'N/A';
                              String day = snapshot.data?['day'] ?? 'N/A';
                              dynamic clocktime =
                                  snapshot.data?['clocktime'] ?? 'N/A';
                              String month = snapshot.data?['month'] ?? 'N/A';
                              String year = snapshot.data?['year'] ?? 'N/A';
                              if (snapshot.hasError) {
                                return ListTile(
                                  title: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                return Card(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ListTile(
                                    title: Text(
                                      locationName,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 20),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: Colors.pink[600],
                                    ),
                                    subtitle: Text(
                                      time,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat bold',
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                    onTap: () {
                                      Navigator.popAndPushNamed(
                                          context, '/worldtime',
                                          arguments: {
                                            'location': locationName,
                                            'time': time,
                                            'day': day,
                                            'clocktime': clocktime,
                                            'weekDay': weekDay,
                                            'month': month,
                                            'year': year,
                                          });
                                      // updateTime(index);
                                    },
                                  ),
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate2 extends SearchDelegate {
  final List<String> formattedLocations;
  final Function(String) getOriginalLocations;
  final Future<Map<String, dynamic>> Function(String) getAlltime;

  CustomSearchDelegate2(
      {required this.formattedLocations,
      required this.getOriginalLocations,
      required this.getAlltime});

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var location in formattedLocations) {
      if (location.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(location);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Card(
          color: Colors.transparent,
          elevation: 0,
          //shape: Border(top: BorderSide(color: Colors.grey)),
          child: ListTile(
            title: Text(
              result,
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            onTap: () async {
              String originalLocation = getOriginalLocations(result);
              Map<String, dynamic> data = await getAlltime(originalLocation);
              close(context, null);
              Navigator.popAndPushNamed(context, '/worldtime', arguments: {
                'location': result,
                'time': data['time'],
                'day': data['day'],
                'clocktime': data['clocktime'],
                'weekDay': data['weekDay'],
                'month': data['month'],
                'year': data['year'],
              });
            },
          ),
        );
      },
    );
  }

  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var location in formattedLocations) {
      if (location.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(location);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Card(
          color: Colors.transparent,
          elevation: 0,
          //shape: Border(top: BorderSide(color: Colors.grey)),
          child: ListTile(
            title: Text(
              result,
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            onTap: () async {
              String originalLocation = getOriginalLocations(result);
              Map<String, dynamic> data = await getAlltime(originalLocation);
              close(context, null);
              Navigator.popAndPushNamed(context, '/worldtime', arguments: {
                'location': result,
                'time': data['time'],
                'day': data['day'],
                'clocktime': data['clocktime'],
                'weekDay': data['weekDay'],
                'month': data['month'],
                'year': data['year'],
              });
            },
          ),
        );
      },
    );
  }
}
