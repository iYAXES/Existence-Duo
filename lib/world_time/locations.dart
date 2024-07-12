import 'package:flutter/material.dart';
import 'package:world_and_weather_app/world_time/worldtime.dart';

class ChooseLocation2 extends StatefulWidget {
  const ChooseLocation2({super.key});

  @override
  State<ChooseLocation2> createState() => _ChooseLocation2State();
}

class _ChooseLocation2State extends State<ChooseLocation2> {
  List<WorldTime> locations = [
    WorldTime(location: 'Lagos', url: 'Africa/Lagos', isChecked: false),
    WorldTime(location: 'Chicago', url: 'America/Chicago', isChecked: false),
    WorldTime(location: 'London', url: 'Europe/London', isChecked: false),
    WorldTime(location: 'Qatar', url: 'Asia/Qatar', isChecked: false),
    WorldTime(location: 'NewYork', url: 'America/New_York', isChecked: false),
    WorldTime(location: 'Germany', url: 'Europe/Berlin', isChecked: false),
    WorldTime(location: 'Egypt', url: 'Africa/Cairo', isChecked: false),
    WorldTime(location: 'South Korea', url: 'Asia/Seoul', isChecked: false),
    WorldTime(
        location: 'Australia', url: 'Australia/Melbourne', isChecked: false),
    WorldTime(location: 'Dubai', url: 'Asia/Dubai', isChecked: false),
    WorldTime(
        location: 'South Africa', url: 'Africa/Johannesburg', isChecked: false),
    WorldTime(
        location: 'Argentina',
        url: 'America/Argentina/Salta',
        isChecked: false),
    WorldTime(location: 'Palmer', url: 'Antarctica/Palmer', isChecked: false),
    WorldTime(location: 'Bangkok', url: 'Asia/Bangkok', isChecked: false),
    WorldTime(location: 'Atlantic', url: 'Atlantic/Canary', isChecked: false),
    WorldTime(location: 'Istanbul', url: 'Europe/Istanbul', isChecked: false),
    WorldTime(location: 'Tahiti', url: 'Pacific/Tahiti', isChecked: false),
  ];

  void updateTime(index) async {
    WorldTime newtime = locations[index];
    await newtime.getWorldTime();
    Navigator.popAndPushNamed(context, '/worldtime', arguments: {
      'time': newtime.time,
      'location': newtime.location,
      'clocktime': newtime.clocktime,
      'day': newtime.day,
      'weekDay': newtime.weekDay,
      'year': newtime.year,
      'month': newtime.month,
    });
  }

  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 80, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Choose Location',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 1),
            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.onSecondary,
                    elevation: 0,
                    child: ListTile(
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: Colors.pink[600],
                      ),
                      title: Text(
                        '${locations[index].location}',
                        style: TextStyle(fontFamily: 'Montserrat bold'),
                      ),
                      onTap: () {
                        updateTime(index);
                      },
                    ),
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



// CheckboxListTile(
//                         title: Text(
//                           '${locations[index].location}',
//                           style: TextStyle(fontFamily: 'Montserrat bold'),
//                         ),
//                         checkboxShape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5)),
//                         activeColor: Colors.pink[600],
//                         checkColor: Colors.white,
//                         value: locations[index].isChecked,
//                         onChanged: (bool? newValue) {
//                           setState(() {
//                             locations[index].isChecked = newValue;
//                           });
//                         },
//                       )