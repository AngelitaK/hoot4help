import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DistancePage extends StatelessWidget {
  final Position requesterLocation;
  final Position helperLocation;

  DistancePage({required this.requesterLocation, required this.helperLocation});

  double calculateDistance() {
    double distance = Geolocator.distanceBetween(
      requesterLocation.latitude,
      requesterLocation.longitude,
      helperLocation.latitude,
      helperLocation.longitude,
    );
    return distance;
  }

  @override
  Widget build(BuildContext context) {
    double distance = calculateDistance();
    Color distanceColor = distance < 1000
        ? Colors.green
        : Colors.red; // 1000 meters (1 km) as the threshold

    return Scaffold(
      appBar: AppBar(
        title: Text('Distance Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Distance between Requester and Helper:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '${distance.toStringAsFixed(2)} meters',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: 100,
              height: 100,
              color: distanceColor,
            ),
            SizedBox(height: 20),
            Text(
              'Requester Location:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Latitude: ${requesterLocation.latitude.toStringAsFixed(6)}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Longitude: ${requesterLocation.longitude.toStringAsFixed(6)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Helper Location:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Latitude: ${helperLocation.latitude.toStringAsFixed(6)}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Longitude: ${helperLocation.longitude.toStringAsFixed(6)}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
