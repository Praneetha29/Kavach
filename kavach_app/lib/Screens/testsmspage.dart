import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class SendMessageWidget extends StatefulWidget {
  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final Telephony telephony = Telephony.instance;

  Future<void> sendSmsInBackground() async {
    // Verify the SMS permission.
    if (await telephony.requestSmsPermissions == true) {
      // Proceed to send the SMS.

      // Here you would get the user's location. For now, let's use a placeholder message.
      String message = "Emergency! The user may have had an accident at: {insert_location_here}";

      // List of emergency contact numbers.
      List<String> phoneNumbers = ['+918309196050', '+918249806939'];

      // Iterate through the contact numbers and send the SMS.
      for (String number in phoneNumbers) {
        await telephony.sendSms(
          to: number,
          message: message,
        );
      }

      // Consider adding some UI feedback or log to show success.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Emergency SMS sent to contacts.'),
        ),
      );
    } else {
      // Handle the failure of obtaining permission.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('SMS permission is required to send messages.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency SMS Sender'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: sendSmsInBackground,
          child: Text('Send Emergency SMS'),
        ),
      ),
    );
  }
}