import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HelperPage extends StatelessWidget {
  final Position requesterLocation;

  HelperPage({required this.requesterLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helper Page'),
      ),
      body: Center(
        child: Text(
          'Requester Location: ${requesterLocation.latitude}, ${requesterLocation.longitude}',
        ),
      ),
    );
  }
}
