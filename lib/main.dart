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
      title: 'Hoot4Help',
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
            ElevatedButton(
              onPressed: () async {
                // Request location permission when "Help Me!" button is pressed
                LocationPermission permission =
                    await Geolocator.requestPermission();

                if (permission == LocationPermission.denied) {
                  print('Location permissions are denied');
                } else if (permission == LocationPermission.deniedForever) {
                  print("Location permissions are permanently denied");
                } else {
                  // If permission is granted, obtain the location and navigate to HelperPage
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
                }
              },
              child: Text('Help Me!'),
            ),
          ],
        ),
      ),
    );
  }
}
