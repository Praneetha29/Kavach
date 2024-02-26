import 'dart:async';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text("Emergency Alert"),
        backgroundColor: Color(0XFF005653),
      ),
      body: Center(
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
    );
  }

  Future<void> sendMessage() async {
    setState(() {
      _isLoading = true;
    });

    final String message = "Emergency, the user has met with an accident and requires immediate attention. Location: <Your-Google-Maps-Link>";
    await sendSms(message);
    await sendEmail(message);

    setState(() {
      _isLoading = false;
      _seconds = 20; // Reset the countdown
    });
    // Optionally, navigate away from this screen
  }

  Future<void> sendSms(String messageBody) async {
    // Predefined phone numbers
    List<String> phoneNumbers = ['+918245780', '+0987654321'];

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

    // GoogleAuthApi.signOut();
    //  return;
    try {
      final user = await GoogleAuthApi.signIn();
      if (user == null) {
        showSnackBar('Google Sign In failed.');
        return;
      }

      final email = user.email;
      final auth = await user.authentication;
      final accessToken = auth.accessToken;

      if (email == null || accessToken == null) {
        showSnackBar('Failed to authenticate for email sending.');
        return;
      }

      final smtpServer = gmailSaslXoauth2(email, accessToken);
      final message = Message()
        ..from = Address(email, 'Your Name')
        ..recipients = ['abc@gmail.com'] // Change to the actual recipient's email address
        ..subject = 'Emergency Message ${DateTime.now()}'
        ..text = messageBody;

      await send(message, smtpServer);
      showSnackBar('Email sent successfully.');
    } on MailerException catch (e) {
      showSnackBar('Failed to send email: ${e.toString()}');
    } catch (e) {
      showSnackBar('An unexpected error occurred: ${e.toString()}');
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

class GoogleAuthApi {
  static final _googleSignIn = GoogleSignIn(scopes: ['https://mail.google.com/']);

  static Future<GoogleSignInAccount?> signIn() async {
    if (await _googleSignIn.isSignedIn()) {
      return _googleSignIn.currentUser;
    } else {
      return await _googleSignIn.signIn();
    }
  }

  static Future signOut() => _googleSignIn.signOut();
}