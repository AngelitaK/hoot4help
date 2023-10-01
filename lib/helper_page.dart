import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'distance_page.dart';

class HelperPage extends StatefulWidget {
  final Position requesterLocation;

  HelperPage({required this.requesterLocation});

  @override
  _HelperPageState createState() => _HelperPageState();
}

class _HelperPageState extends State<HelperPage> {
  //helper long lat will be hardcoded as for now since im testing using 1 device
  final Position helperLocation = Position.fromMap({
    'latitude': 1.297276,
    'longitude': -256.150492,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helper Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Requester Location:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Latitude: ${widget.requesterLocation.latitude}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Longitude: ${widget.requesterLocation.longitude}',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DistancePage(
                      requesterLocation: widget.requesterLocation,
                      helperLocation: helperLocation,
                    ),
                  ),
                );
              },
              child: Text('Check Distance'),
            ),
          ],
        ),
      ),
    );
  }
}
