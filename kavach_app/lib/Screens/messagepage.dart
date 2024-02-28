import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:telephony/telephony.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kavach_app/Screens/google_auth_api.dart';
import 'package:kavach_app/Screens/map_screen.dart';


class MessageServicePage extends StatefulWidget {
  @override
  _MessageServicePageState createState() => _MessageServicePageState();
}

class _MessageServicePageState extends State<MessageServicePage> {
  final Telephony telephony = Telephony.instance;
  Timer? _countdownTimer;
  bool _isLoading = false;
  int _seconds = 20;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        sendMessage();
        timer.cancel();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  void stopAlert() {
    _countdownTimer?.cancel();
    setState(() => _seconds = 20);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MapScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Padding(
        padding: EdgeInsets.only(top: 70), // Adjust the top value to add space
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Accident Detected',
                  style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Text(
                  'If you are safe, press STOP',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.redAccent,
                    padding: EdgeInsets.all(20),
                    textStyle: TextStyle(fontSize: 26),
                  ),
                  onPressed: () {
                    stopAlert();
                    // Inform the user if needed
                  },
                  child: Text('STOP'),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 260,
                        height: 260,
                        child: CircularProgressIndicator(
                          value: _seconds / 20,
                          strokeWidth: 10,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$_seconds',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> sendMessage() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied && permission != LocationPermission.deniedForever) {
      var currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${currentPosition.latitude},${currentPosition.longitude}';
      final String message = "Emergency, the user has met with an accident and requires immediate attention. Location: $googleMapsUrl";

      setState(() => _isLoading = true);

      await sendSms(message);
      await sendEmail(message);

      setState(() => _isLoading = false);
    }
    // Optionally, navigate away from this screen
  }

  Future<void> sendSms(String messageBody) async {
    // Predefined phone numbers
    List<String> phoneNumbers = ['+9112345678', '+0987654321'];

    final isGranted = await telephony.requestSmsPermissions;
    if (isGranted == true) {
      for (var number in phoneNumbers) {
        telephony.sendSms(
          to: number,
          message: messageBody,
        );
      }
    } else {
      showSnackBar("SMS permission is required to send messages.");
    }
  }

  Future<void> sendEmail(String messageBody) async {
    //
    // GoogleAuthApi.signOut();
    //  return;
    final GoogleSignInAccount? googleUser = await GoogleAuthApi.signIn();

    // If signing in was successful, retrieve the authentication details.
    if (googleUser != null) {
      final email = googleUser.email;
      final GoogleSignInAuthentication auth = await googleUser.authentication;
      final accessToken = auth.accessToken;

      // Set up the SMTP server using the authentication details.
      final smtpServer = gmailSaslXoauth2(email, accessToken!);
      final message = Message()
        ..from = Address(email, 'Kavach')
        ..recipients = ['abc@gmail.com']
        ..subject = 'Emergency Alert ${DateTime.now()}'
        ..text = (messageBody);

      // Send the email message.
      await send(message, smtpServer);
      showSnackBar('Email sent successfully.');
    } else {
      showSnackBar('Google Sign In failed. Cannot send email.');
    }
  }


  void showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }
}

