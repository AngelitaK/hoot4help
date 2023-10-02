import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter_compass/flutter_compass.dart';

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
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription<Position> _positionStreamSubscription;
  // String _latitude = 'Unknown';
  // String _longitude = 'Unknown';
  double targetLatitude = 1.453;
  double targetLongitude = 103.83;
  String distance = 'Calculating...';
  String bearing = '0';
  double heading = 0;
  double originalDistance = 0;
  Color textColor = Colors.black; // Initialize text color

  Future<bool> handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndStartLocationUpdates();
  }

  Future<void> _checkPermissionsAndStartLocationUpdates() async {
    bool hasPermission = await handlePermission();

    if (hasPermission) {
      _startLocationUpdates();
    }
  }

  @override
  void dispose() {
    _stopLocationUpdates();
    super.dispose();
  }

  void _calculateDistance(Position currentPosition) {
    double currentLatitude = currentPosition.latitude;
    double currentLongitude = currentPosition.longitude;
    double result = Geolocator.distanceBetween(
      currentLatitude,
      currentLongitude,
      targetLatitude,
      targetLongitude,
    );
    double bearingResult = Geolocator.bearingBetween(
      currentLatitude,
      currentLongitude,
      targetLatitude,
      targetLongitude,
    );
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = bearingResult - event.heading!;
      });
    });
    // Check if getting closer or further and update text color accordingly
    setState(() {
      // _latitude = currentLatitude.toStringAsFixed(6);
      // _longitude = currentLongitude.toStringAsFixed(6);
      distance = result.toStringAsFixed(2);
      bearing = bearingResult.toStringAsFixed(2);

      if (result < originalDistance) {
        textColor = Colors.green; // Closer, change to blue
      } else {
        textColor = Colors.red; // Further, change to red
      }
    });
    originalDistance = result;
  }

  void _startLocationUpdates() async {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (Position position) {
        _calculateDistance(position);
      },
      onError: (error) {
        setState(() {
          distance = 'Error: $error';
        });
      },
    );
  }

  void _stopLocationUpdates() {
    _positionStreamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240,203,168),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.jpg',
              scale: 5,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Hoot4Help',
              style: TextStyle(color: Color.fromARGB(255, 240,203,168)),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 110, 84, 60),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Distance Left: ${distance}m',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, color: textColor),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Transform.rotate(
                angle: vector.radians(heading), // Convert degrees to radians
                child: const Icon(
                  Icons.arrow_upward,
                  size: 200,
                  color: Color.fromARGB(255, 184, 115, 51),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
