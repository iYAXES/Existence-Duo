import 'dart:convert' as convert;

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  dynamic clocktime;
  String? url;
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
    Response response =
        await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = convert.jsonDecode(response.body);
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    int day_of_week = data['day_of_week'];
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));
    clocktime = now;
    time = DateFormat.jm().format(now);
    day = DateFormat('d').format(now);
    am_pm = DateFormat('a').format(now);

    DateTime formatWeek = DateTime(day_of_week);
    weekDay = DateFormat('EEEE').format(formatWeek);
    month = DateFormat.MMMM().format(now);
    year = DateFormat.y().format(now);
    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
  }
}
