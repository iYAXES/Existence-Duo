import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_and_weather_app/weather/weatherService.dart';
import 'package:provider/provider.dart';
import 'package:world_and_weather_app/provider_test.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  Map W_data = {};
  WeatherServices weatherServices = WeatherServices();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    W_data = W_data.isNotEmpty
        ? W_data
        : ModalRoute.of(context)?.settings.arguments as Map;
    //String isDayTime = W_data['isDayTime'] ? 'bg.jpg' : 'bg1.jpg';
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).colorScheme.onSecondary,
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
            ])),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Existence Duo',
                    style: TextStyle(fontFamily: 'Howvetical', fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                      icon: Icon(
                        Icons.nightlight,
                        size: 24,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                '${W_data['location']}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 25,
                  fontFamily: 'Montserrat bold',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${W_data['tempC']}'.substring(0, 2),
                    style: TextStyle(
                        fontSize: 100,
                        fontFamily: 'Montserrat',
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 35),
                    child: Text(
                      '℃',
                      style: TextStyle(
                          fontFamily: 'Montserrat bold',
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 30),
                    ),
                  )
                ],
              ),
              FittedBox(
                child: Container(
                  child: Text(
                    '${W_data['condition']}',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cloud: ${W_data['cloudlevel']}% Heat: ${W_data['heatlevel']}℃',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat bold',
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      //backgroundBlendMode: BlendMode.modulate,
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.onSecondary),
                  height: 175,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/forcast',
                                  arguments: {
                                    'getDay': W_data['getDay'],
                                  });
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Forecast',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue[300],
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 115,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: W_data['getHour'].length,
                          itemBuilder: (context, index) {
                            String formatTime =
                                DateFormat('HH:mm:ss').format(DateTime.now());
                            String currentHour = formatTime.substring(0, 2);
                            String forecastHour =
                                W_data['getHour'][index]['time'];
                            DateTime format = DateTime.parse(forecastHour);
                            //format the forcast show Hours and PM
                            String formatHour = DateFormat.j().format(format);
                            String forecastTime = W_data['getHour'][index]
                                    ['time']
                                .substring(11, 13);
                            //forecast Time to show only the Hours to use for selected current Time
                            String forecastIcon =
                                W_data['getHour'][index]['condition']['icon'];
                            double forecastTemp =
                                W_data['getHour'][index]['temp_c'];

                            return Container(
                              width: 80,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 2,
                                      color: currentHour == forecastTime
                                          ? Colors.white
                                          : Colors.blueGrey.shade600),
                                  color: currentHour == forecastTime
                                      ? Colors.black
                                      : Colors.blueGrey[600]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatHour,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat bold',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Image.network('https:$forecastIcon'),
                                  ),
                                  Text(
                                    '$forecastTemp'.substring(0, 2) + '°',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Montserrat bold',
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                height: 130,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: ListTile(
                          leading: Icon(
                            Icons.cloudy_snowing,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 50,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Get More City Updates.',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              Text(
                                'Locations, Weather and Condition',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                    Divider(
                      indent: 95,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          dynamic data = await Navigator.pushNamed(
                              context, '/weatherlocation');
                          if (data != null) {
                            setState(() {
                              W_data = {
                                'location': data['location'],
                                'condition': data['condition'],
                                'tempC': data['tempC'],
                                'heatlevel': data['heatlevel'],
                                'cloudlevel': data['cloudlevel'],
                                'getHour': data['getHour'],
                                'getDay': data['getDay'],
                              };
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Select City',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Montserrat bold',
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              SizedBox(
                                width: 144,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
