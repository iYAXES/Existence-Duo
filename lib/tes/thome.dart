import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class tuesdayHome extends StatefulWidget {
  const tuesdayHome({super.key});

  @override
  State<tuesdayHome> createState() => _tuesdayHomeState();
}

class _tuesdayHomeState extends State<tuesdayHome> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${data['location']}',
                  style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                ),
                IconButton(
                    onPressed: () async {
                      dynamic results =
                          await Navigator.pushNamed(context, '/tlocations');
                      if (results != null) {
                        setState(() {
                          data = {
                            'location': results['location'],
                            'temperature': results['temperature'],
                            'condition': results['condition'],
                            'forecastHour': results['forecastHour'],
                          };
                        });
                      }
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${data['condition']}',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${data['temperature']}',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: data['forecastHour'].length,
                itemBuilder: (context, index) {
                  double forecastTemp = data['forecastHour'][index]['temp_c'];
                  String forecastIcon =
                      data['forecastHour'][index]['condition']['icon'];
                  String forecastHour = data['forecastHour'][index]['time'];
                  DateTime formatH = DateTime.parse(forecastHour);
                  String formatHour = DateFormat.j().format(formatH);

                  String currentFormat = DateFormat.j().format(DateTime.now());
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: EdgeInsets.only(right: 10),
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: currentFormat == formatHour
                            ? Colors.teal
                            : Colors.blue[800]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$formatHour'),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage('https:$forecastIcon'),
                          radius: 30,
                        ),
                        Text('$forecastTemp'),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
