import 'package:flutter/material.dart';

class testThursday extends StatefulWidget {
  const testThursday({super.key});

  @override
  State<testThursday> createState() => _testThursdayState();
}

class _testThursdayState extends State<testThursday> {
  int bottle = 0;

  void order() {
    setState(() {
      bottle = bottle < 5 ? bottle + 1 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giottos Bar'),
      ),
      body: Container(
        height: 300,
        margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.white60),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Bottle: ',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 24),
                ),
                for (int i = 0; i < bottle; i++)
                  Image(
                    image: AssetImage('assets/bottle.png'),
                    width: 35,
                  ),
                Expanded(child: SizedBox()),
                ElevatedButton(
                    onPressed: () {
                      order();
                    },
                    child: Icon(Icons.add),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
