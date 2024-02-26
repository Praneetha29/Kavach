import 'package:flutter/material.dart';
import 'package:kavach_app/Screens/google_auth_api.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

// Replace with your actual details


class TestEmailPage extends StatefulWidget {
  const TestEmailPage({Key? key}) : super(key: key);

  @override
  _TestEmailPageState createState() => _TestEmailPageState();
}

class _TestEmailPageState extends State<TestEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Email"),
        backgroundColor: Color(0XFF005653),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Replace with your actual navigation to MapScreen
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0XFF005653), // background color
            onPrimary: Colors.white, // text color
            padding: EdgeInsets.all(20),
            textStyle: TextStyle(fontSize: 26),
          ),
          child: Text('Send Email'),
          onPressed: sendEmail,
        ),
      ),
    );
  }

  Future<void> sendEmail() async {
    final user=await GoogleAuthApi.signIn();

    if(user == null) return;

    final  email = user.email;
    final auth = await user.authentication;
    final token = auth.accessToken!;

    print('Authenticated: $email');
    final smtpServer = gmailSaslXoauth2(email, token);

    final message = Message()
      ..from = Address(email, 'Kav')
      ..recipients = ['abc@gmail.com']
      ..subject = 'Flutter Email Test ${DateTime.now()}'
      ..text = 'This is a test email sent from Flutter app.';

    try {
      await send(message, smtpServer);
      showSnackBar('Email sent successfully!');
    } on MailerException catch (e) {
      showSnackBar('Failed to send email: ${e.toString()}');
    }
  }




  void showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}