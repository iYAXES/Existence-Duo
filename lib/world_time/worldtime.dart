import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  final String location;
  dynamic clocktime;
  final String url;
  String? time;
  String? day;
  String? weekDay;
  String? month;
  String? year;
  String? am_pm;
  bool? isDayTime;
  WorldTime({
    required this.location,
    required this.url,
  });

  Future<void> getWorldTime() async {
    try {
      // var uri = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      var uri = Uri.https(
          'www.timeapi.io', '/api/time/current/zone', {'timeZone': url});
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        Map data = convert.jsonDecode(response.body);

        String datetime = data['dateTime'];
        //String offset = data['utc_offset'].substring(1, 3);

        //int day_of_week = data['day_of_week'];
        DateTime now = DateTime.parse(datetime);
        // now = now.add(Duration(hours: int.parse(offset)));
        clocktime = now;
        time = DateFormat.jm().format(now);
        day = DateFormat('d').format(now);
        am_pm = DateFormat('a').format(now);

        // DateTime formatWeek = DateTime(day_of_week);
        weekDay = DateFormat('EEEE').format(now);
        month = DateFormat.MMMM().format(now);
        year = DateFormat.y().format(now);
        isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      } else {
        print('Unable to get Data from API: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching world time: $e');
      rethrow;
    }
  }
}
