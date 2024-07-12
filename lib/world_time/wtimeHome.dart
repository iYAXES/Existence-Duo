import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:world_and_weather_app/weather/loading.dart';
import 'package:world_and_weather_app/world_time/locations.dart';

class WorldTimeHome extends StatefulWidget {
  const WorldTimeHome({super.key});

  @override
  State<WorldTimeHome> createState() => _WorldTimeHomeState();
}

class _WorldTimeHomeState extends State<WorldTimeHome> {
  List screens = [Clock(), ChooseLocation2(), Loading()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF091057),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          elevation: 0,
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(color: Colors.pink[600]),
          selectedLabelStyle: TextStyle(
            fontFamily: 'Montserrat bold',
          ),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Color(0xFF091057),
                icon: Icon(
                  Icons.alarm,
                ),
                label: 'Clock'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.background,
                icon: Icon(
                  Icons.list_rounded,
                ),
                label: 'List'),
            BottomNavigationBarItem(
                backgroundColor: Colors.grey[850],
                icon: Icon(
                  Icons.exit_to_app,
                ),
                label: 'Exit'),
          ]),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Map data = {};

  // int addtest = 0;
  // void addContainer() {
  //   setState(() {
  //     addtest = addtest < 4 ? addtest + 1 : 1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;

    return Container(
      padding: EdgeInsets.fromLTRB(10, 140, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 4, top: 5),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/clock.png'), fit: BoxFit.cover)),
            height: 280,
            width: 280,
            child: AnalogClock(
              hourNumberRadiusFactor: .7,
              dateTime: data['clocktime'],
              dialColor: null,
              secondHandLengthFactor: .8,
              minuteHandWidthFactor: 1.4,
              secondHandWidthFactor: 1.5,
              minuteHandLengthFactor: .7,
              hourHandLengthFactor: .72,
              hourHandColor: Colors.pink[600],
              minuteHandColor: Colors.grey,
              markingColor: null,
              hourNumberColor: Colors.black,
              secondHandColor: Color(0xFF091057),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${data['location']}',
            style: TextStyle(
                fontFamily: 'Montserrrat bold',
                fontSize: 35,
                color: Colors.pink[600]),
          ),
          Text(
            '${data['time']}',
            style: TextStyle(
                fontFamily: 'Montserrat bold',
                fontSize: 54,
                color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${data['weekDay']},',
                style: TextStyle(
                    fontSize: 18, fontFamily: 'Montserrat', color: Colors.grey),
              ),
              Text(
                ' ${data['day']}',
                style: TextStyle(
                    color: Colors.grey, fontFamily: 'Howvetical', fontSize: 24),
              ),
              Text(
                ' ${data['month']} ${data['year']}',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontSize: 18, color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
