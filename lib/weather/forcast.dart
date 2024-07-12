import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Forcast extends StatefulWidget {
  const Forcast({super.key});

  @override
  State<Forcast> createState() => _ForcastState();
}

class _ForcastState extends State<Forcast> {
  Map forcast = {};
  @override
  Widget build(BuildContext context) {
    forcast = ModalRoute.of(context)?.settings.arguments as Map;

    String icon = forcast['getDay'][1]['day']['condition']['icon'];
    double tomWeda = forcast['getDay'][1]['day']['maxtemp_c'];
    double tomWeda2 = forcast['getDay'][1]['day']['mintemp_c'];
    String condition = forcast['getDay'][1]['day']['condition']['text'];
    double wind = forcast['getDay'][1]['day']['maxwind_mph'];
    int humidity = forcast['getDay'][1]['day']['avghumidity'];
    int rainy = forcast['getDay'][1]['day']['daily_chance_of_rain'];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Forecast',
          style: TextStyle(fontFamily: 'Montserrat bold', fontSize: 18),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue.shade300,
                        Colors.blue.shade800,
                        Colors.purple.shade900,
                      ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        '3 Days',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat bold',
                            fontSize: 18),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Image.network(
                            'https:$icon',
                            fit: BoxFit.contain,
                          ),
                        ),
                        flex: 1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tommorow',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '$tomWeda'.substring(0, 2),
                                    style: TextStyle(
                                        fontSize: 44,
                                        fontFamily: 'Howvetical',
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '/' + '$tomWeda2'.substring(0, 2) + '°',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Montserrat bold',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                condition,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.white,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.air,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$wind' + ' km/h',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat bold',
                                color: Colors.white),
                          ),
                          Text('Wind',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white))
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$humidity' + '%',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat bold',
                                color: Colors.white),
                          ),
                          Text('Humidity',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white))
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.water,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$rainy' + '%',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat bold',
                                color: Colors.white),
                          ),
                          Text('Chance of rain',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 300,
              child: ListView.builder(
                itemCount: forcast['getDay'].length,
                itemBuilder: (context, index) {
                  String forcastDay = forcast['getDay'][index]['date'];
                  DateTime format = DateTime.parse(forcastDay);
                  String formatDay = DateFormat('EEEE').format(format);
                  String forcastIcon =
                      forcast['getDay'][index]['day']['condition']['icon'];
                  String forcastCondi =
                      forcast['getDay'][index]['day']['condition']['text'];
                  double forcastTemp =
                      forcast['getDay'][index]['day']['maxtemp_c'];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDay,
                        style: TextStyle(
                            //color: Colors.white,
                            fontFamily: 'Howvetical',
                            fontSize: 15),
                      ),
                      Row(
                        children: [
                          Image.network(
                            'https:$forcastIcon',
                          ),
                          Text(forcastCondi,
                              style: TextStyle(
                                  // color: Colors.white,
                                  fontFamily: 'Montserrat')),
                        ],
                      ),
                      Text('$forcastTemp'.substring(0, 2) + '°',
                          style: TextStyle(
                              //color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Montserrat bold')),
                    ],
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
