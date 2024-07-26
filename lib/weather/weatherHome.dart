import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_and_weather_app/weather/weatherService.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 70, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${W_data['location']}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Montserrat bold',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${W_data['tempC']}'.substring(0, 2),
                    style: TextStyle(
                        fontSize: 85,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 35),
                    child: Text(
                      '℃',
                      style: TextStyle(
                          fontFamily: 'Montserrat bold',
                          color: Colors.white,
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
                      color: Colors.white,
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
                      color: Colors.white,
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
                      backgroundBlendMode: BlendMode.modulate,
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueGrey[600]),
                  height: 165,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
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
                                  color: Colors.white,
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
                        height: 110,
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
                            String formatHour = DateFormat.j().format(format);
                            //format the forcast show Hours and PM
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
                              padding: EdgeInsets.symmetric(vertical: 10),
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
                  color: Colors.blueGrey[600],
                ),
                height: 130,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 22, 15, 10),
                        child: ListTile(
                          leading: Icon(
                            Icons.cloudy_snowing,
                            color: Colors.grey[200],
                            size: 50,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Get More City Updates.',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Locations, Weather and Condition',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                    Divider(
                      indent: 100,
                      color: Colors.white,
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
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 144,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
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
