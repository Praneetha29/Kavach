import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';

class SendMessageWidget extends StatefulWidget {
  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final Telephony telephony = Telephony.instance;

  Future<void> sendSmsWithLocation() async {
    // Request SMS permissions and proceed only if permissions are granted
    final bool? smsPermissionsGranted = await telephony.requestSmsPermissions;
    if (smsPermissionsGranted != null && smsPermissionsGranted) {
      try {
        // Get the current location of the device
        Position position = await _determinePosition();

        // Accident location - NIT Rourkela coordinates (Example coordinates)
        const String accidentLatitude = '22.253469';
        const String accidentLongitude = '84.901132';

        // Generate the Google Maps URL
        String mapsUrl = 'https://www.google.com/maps/dir/?api=1&origin=${position.latitude},${position.longitude}&destination=$accidentLatitude,$accidentLongitude';

        // Message with the location URL
        String message = "Emergency! The user may have had an accident. Help needed at this location: $mapsUrl";

        // List of emergency contact numbers
        const List<String> phoneNumbers = ['+918309196050', '919853618169'];

        // Send the emergency SMS with the location
        for (String number in phoneNumbers) {
          await telephony.sendSms(to: number, message: message);
        }

        // UI feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Emergency SMS sent with location.')),
        );
      } catch (e) {
        print('Error occurred while sending SMS: $e');
      }
    } else {
      // Permission denied or not obtained. Handle accordingly.
      print('SMS permission was not granted.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SMS permission required to send emergency messages.')),
      );
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, cannot get the location
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission denied, cannot get the location
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can get the location
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency SMS Sender'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: sendSmsWithLocation,
          child: Text('Send Emergency SMS with Location'),
        ),
      ),
    );
  }
}