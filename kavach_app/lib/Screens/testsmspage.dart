import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:another_flushbar/flushbar.dart';


class SendSmsScreen extends StatefulWidget {
  @override
  _SendSmsScreenState createState() => _SendSmsScreenState();
}

class _SendSmsScreenState extends State<SendSmsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loading = false;
  final Telephony telephony = Telephony.instance;
  late SmsSendStatusListener listener;

  @override
  void initState() {
    super.initState();
    listener = (SendStatus status) {
      setState(() {
        _loading = false;
      });

      String messageStatus = status == SendStatus.SENT ? "Message sent" : "Failed to send message";
      Flushbar(
        title: "Send SMS",
        message: messageStatus,
        duration: Duration(seconds: 3),
        backgroundColor: Color(0XFF005653),
      ).show(context);
    };
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Send SMS"),
            backgroundColor: Color(0XFF005653),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Replace the following line with the navigation to your MapScreen.
                Navigator.of(context).pop(); // e.g. Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MapScreen()));
              },
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0XFF005653), // background color
                    onPrimary: Colors.white, // text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color(0XFF005653)),
                    ),
                  ),
                  onPressed: onSendSmsTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Use min to avoid stretching
                      children: [
                        Icon(Icons.send, size: 17, color: Colors.white),
                        const SizedBox(width: 5),
                        Text("Send".toUpperCase(), style: TextStyle(fontSize: 14, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSendSmsTap() {
    FocusScope.of(context).unfocus();

    // Predefined phone numbers
    List<String> phoneNumbers = ['+91012345', '+0987654321'];

    String accidentLatitude = '37.422'; // Hypothetical accident latitude
    String accidentLongitude = '-122.084'; // Hypothetical accident longitude
    String mapsUrl = "https://www.google.com/maps/dir/?api=1&destination=$accidentLatitude,$accidentLongitude";
    String message = "Emergency! The user may have had an accident. Help needed at this location: $mapsUrl";

    // Request SMS permissions and send messages to the predefined numbers
    telephony.requestSmsPermissions.then((bool? granted) {
      if (granted == true) {
        phoneNumbers.forEach((number) {
          telephony.sendSms(
            to: number,
            message: message,
            statusListener: listener,
          );
        });
        setState(() {
          _loading = true;
        });
      } else {
        Flushbar(
          title: "SMS Permission",
          message: "SMS permission is required to send messages.",
          duration: Duration(seconds: 3),
          backgroundColor: Color(0XFF005653),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      }
    });
  }
}