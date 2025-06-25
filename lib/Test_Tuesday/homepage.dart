import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:fl_chart/fl_chart.dart';

class Thomepage extends StatefulWidget {
  const Thomepage({super.key});

  @override
  State<Thomepage> createState() => _ThomepageState();
}

class _ThomepageState extends State<Thomepage> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    Gradient isDaytime = data['isDayTime']
        ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
                Colors.blue.shade600,
                Colors.blue.shade500,
                Colors.blue.shade400,
                Colors.blue.shade200,
              ])
        : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
                Colors.grey.shade900,
                Colors.grey.shade800,
                Colors.grey.shade700,
                Colors.grey.shade600,
              ]);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        decoration: BoxDecoration(
          gradient: isDaytime,
          // gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [
          //   Colors.blue.shade600,
          //   Colors.blue.shade500,
          //   Colors.blue.shade400,
          //   Colors.blue.shade200,
          // ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                Text(
                  '${data['location']}',
                  style: TextStyle(
                      fontFamily: 'Montserrat bold',
                      fontSize: 24,
                      color: Colors.white),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.location_on))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data['tempC']}'.substring(0, 2) + '°',
                          style: TextStyle(
                              fontFamily: 'montserrat bold',
                              fontSize: 70,
                              color: Colors.white),
                        ),
                        FittedBox(
                          child: Text(
                            '${data['condition']}',
                            style: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FittedBox(
                          child: Text(
                              style: TextStyle(
                                  fontFamily: 'Montserrat bold', fontSize: 16),
                              'Day: ' +
                                  '${data['forecastHour'][13]['temp_c']}'
                                      .substring(0, 2) +
                                  '°' +
                                  ' /' +
                                  ' Night:' +
                                  ' ${data['forecastHour'][22]['temp_c']}'
                                      .substring(0, 3) +
                                  '°' +
                                  ' Feels like' +
                                  ' ${data['feelslikeC']}'.substring(0, 3) +
                                  '°'),
                        )
                      ],
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      child: Image.network(
                        'https:${data['icon']}',
                        fit: BoxFit.contain,
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: data['forecastHour'].length,
                itemBuilder: (context, index) {
                  String icon =
                      data['forecastHour'][index]['condition']['icon'];
                  String forecastTime = data['forecastHour'][index]['time'];
                  DateTime format = DateTime.parse(forecastTime);
                  String formatT = DateFormat.j().format(format);
                  double tempC = data['forecastHour'][index]['temp_c'];
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(8),
                    height: 100,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$formatT',
                          style: TextStyle(color: Colors.white70),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage('https:$icon'),
                        ),
                        Text('$tempC'.substring(0, 2) + '°'),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(.4),
                  borderRadius: BorderRadius.circular(25)),
            )
          ],
        ),
      ),
    );
  }
}
