import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_and_weather_app/world_time/worldtime.dart';

class LoadingScreen2 extends StatefulWidget {
  const LoadingScreen2({super.key});

  @override
  State<LoadingScreen2> createState() => _LoadingScreen2State();
}

class _LoadingScreen2State extends State<LoadingScreen2> {
  void setUpWorldTime() async {
    WorldTime newtime = WorldTime(location: 'Nigeria', url: 'Africa/Lagos');
    await newtime.getWorldTime();
    Navigator.pushReplacementNamed(context, '/worldtime', arguments: {
      'clocktime': newtime.clocktime,
      'time': newtime.time,
      'day': newtime.day,
      'weekDay': newtime.weekDay,
      'am_pm': newtime.am_pm,
      'month': newtime.month,
      'year': newtime.year,
      'location': newtime.location,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SpinKitPouringHourGlassRefined(
          color: Theme.of(context).colorScheme.onPrimary,
          size: 60,
        ),
      ),
    );
  }
}
