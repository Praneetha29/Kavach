import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SendMessageWidget extends StatelessWidget {
  final String phoneNumber = '+918309196050';
  final String destinationLatitude = '22.253469'; // NIT Rourkela latitude
  final String destinationLongitude = '84.901132'; // NIT Rourkela longitude

  // Function to generate the Google Maps URL for a mock route
  String createGoogleMapsUrl() {
    // Mock current latitude and longitude
    String mockCurrentLatitude = '37.4220041';
    String mockCurrentLongitude = '-122.0862462';
    return 'https://www.google.com/maps/dir/?api=1&travelmode=driving&dir_action=navigate&destination=$destinationLatitude,$destinationLongitude&origin=$mockCurrentLatitude,$mockCurrentLongitude';
  }

  // Function to launch the SMS app with a pre-filled message
  Future<void> sendSMS() async {
    final String mapsUrl = createGoogleMapsUrl();
    final String message = 'Follow this link to see the route: $mapsUrl';
    final Uri smsUri = Uri.parse('sms:$phoneNumber?body=${Uri.encodeComponent(message)}');

    if (await canLaunch(smsUri.toString())) {
      await launch(smsUri.toString());
    } else {
      throw 'Could not launch SMS app';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: sendSMS,
      child: Text('Test SMS'),
    );
  }
}
