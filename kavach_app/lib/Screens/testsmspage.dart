import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Function to launch the SMS app with pre-filled message
Future<void> sendTestSMS() async {
  const String phoneNumber = '+918309196050';
  const double startPointLat = 12.9716; // Example start latitude (Bangalore)
  const double startPointLong = 77.5946; // Example start longitude (Bangalore)
  const double endPointLat = 13.0016; // Example end latitude (~3km away)
  const double endPointLong = 77.6146; // Example end longitude (~3km away)
  const String landmark = "near the ABC Landmark"; // Example landmark

  // Create the Google Maps URL for the route
  String mapsUrl = 'https://www.google.com/maps/dir/?api=1'
      '&origin=$startPointLat,$startPointLong'
      '&destination=$endPointLat,$endPointLong'
      '&travelmode=driving';

  // Construct the message
  String message = Uri.encodeComponent('Emergency! An accident has occurred $landmark. Follow this route for help: $mapsUrl');

  // Construct the URI for SMS
  String smsUri = 'sms:$phoneNumber?body=$message';

  // Check if the SMS app can be launched
  if (await canLaunch(smsUri)) {
    await launch(smsUri); // Launch the SMS app
  } else {
    print('Failed to send SMS');
  }
}
class TestSmsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test SMS"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            sendTestSMS();
          },
          child: Text('Send Test SMS'),
        ),
      ),
    );
  }
}