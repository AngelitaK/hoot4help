import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DisplayDistancePage extends StatelessWidget {
  final Position requesterLocation;
  final Position helperLocation;

  DisplayDistancePage({
    required this.requesterLocation,
    required this.helperLocation,
  });

  @override
  Widget build(BuildContext context) {
    double distance = Geolocator.distanceBetween(
      requesterLocation.latitude,
      requesterLocation.longitude,
      helperLocation.latitude,
      helperLocation.longitude,
    );

    Color color = distance < 5 ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: Text('Display Distance Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Distance: ${distance.toStringAsFixed(2)} meters'),
            Container(
              width: 100,
              height: 100,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
