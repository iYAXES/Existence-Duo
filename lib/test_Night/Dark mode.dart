import 'package:flutter/material.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  bool modes = false;
  // ThemeData isDark = ThemeData(brightness: Brightness.dark);
  // ThemeData isLight = ThemeData(brightness: Brightness.light);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: modes ? isDark : isLight,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test Page'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Press to Switch Mode'),
              Switch(
                value: modes,
                onChanged: (newvalue) {
                  setState(() {
                    modes = newvalue;
                  });
                },
              ),
              IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.nightlight,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
