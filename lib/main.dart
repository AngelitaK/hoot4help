import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'helper_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Help App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RequesterPage(),
    );
  }
}

class RequesterPage extends StatefulWidget {
  @override
  _RequesterPageState createState() => _RequesterPageState();
}

class _RequesterPageState extends State<RequesterPage> {
  int buttonPressCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requester Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Button Press Count: $buttonPressCount',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () async {
                Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.best,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelperPage(
                      requesterLocation: position,
                    ),
                  ),
                );
              },
              child: Text('Help Me!'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  buttonPressCount++; // Increment the counter
                });
              },
              child: Text('Counter Button'),
            ),
          ],
        ),
      ),
    );
  }
}
