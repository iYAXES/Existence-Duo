import 'package:flutter/material.dart';
import 'package:world_and_weather_app/world_time/worldtime.dart';

class ChooseLocation2 extends StatefulWidget {
  const ChooseLocation2({super.key});

  @override
  State<ChooseLocation2> createState() => _ChooseLocation2State();
}

class _ChooseLocation2State extends State<ChooseLocation2> {
  Map localtime = {};

  List<WorldTime> locations = [
    WorldTime(location: 'Lagos', url: 'Africa/Lagos'),
    WorldTime(location: 'Chicago', url: 'America/Chicago'),
    WorldTime(location: 'London', url: 'Europe/London'),
    WorldTime(location: 'Qatar', url: 'Asia/Qatar'),
    WorldTime(location: 'NewYork', url: 'America/New_York'),
    WorldTime(location: 'Germany', url: 'Europe/Berlin'),
    WorldTime(location: 'Egypt', url: 'Africa/Cairo'),
    WorldTime(location: 'South Korea', url: 'Asia/Seoul'),
    WorldTime(location: 'Australia', url: 'Australia/Melbourne'),
    WorldTime(location: 'Dubai', url: 'Asia/Dubai'),
    WorldTime(location: 'South Africa', url: 'Africa/Johannesburg'),
    WorldTime(location: 'Argentina', url: 'America/Argentina/Salta'),
    WorldTime(location: 'Palmer', url: 'Antarctica/Palmer'),
    WorldTime(location: 'Bangkok', url: 'Asia/Bangkok'),
    WorldTime(location: 'Atlantic', url: 'Atlantic/Canary'),
    WorldTime(location: 'Istanbul', url: 'Europe/Istanbul'),
    WorldTime(location: 'Tahiti', url: 'Pacific/Tahiti'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 80, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Location',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
              ],
            ),
            Divider(color: Colors.grey, thickness: 1),
            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.background,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
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
                      subtitle: Text(''),
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