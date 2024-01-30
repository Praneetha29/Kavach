import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:quickalert/quickalert.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:kavach_app/Database/config.dart';
import 'package:kavach_app/Screens/map_screen.dart';
import 'package:kavach_app/Screens/ViewHistoryPage.dart';
import 'package:kavach_app/Screens/UpdateInformationPage.dart';
import 'package:kavach_app/Screens/AddContactPage.dart';
import 'package:kavach_app/Screens/ChangePasswordPage.dart';

class UserProfile extends StatefulWidget {
  final String token;

  const UserProfile({Key? key, required this.token}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late String username, mobile;
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connect();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    username = decodedToken["username"];
    mobile = decodedToken["mobile"];
  }

  void connect() {
    socket = IO.io(serverURL, <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('Connected');
    });

    socket.on('accidentOccurred', (data) {
      print('Accident occurred!');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Alert!!!',
        text: 'An accident is suspected.',
      );
    });

    socket.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: kToolbarHeight + 20),
          ProfileInfo(username: username, mobile: mobile),
          Expanded(
            child: ListView(
              children: <Widget>[
                ProfileListView(
                  text: 'Home',
                  icon: Icons.home,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen())),
                ),
                ProfileListView(
                  text: 'History',
                  icon: Icons.history,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewHistoryPage())),
                ),
                ProfileListView(
                  text: 'Update Information',
                  icon: Icons.update,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateInformationPage(
                          initialFullName: username,
                          initialMobile: mobile,
                        ),
                      ),
                    );
                  },
                ),
                ProfileListView(
                  text: 'Add Contact',
                  icon: Icons.person_add,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage())),
                ),
                ProfileListView(
                  text: 'Change Password',
                  icon: Icons.lock,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage())),
                ),
                ProfileListView(
                  text: 'Log Out',
                  icon: Icons.logout,
                  onTap: () {
                    // Implement logout logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}

class ProfileInfo extends StatelessWidget {
  final String username;
  final String mobile;

  const ProfileInfo({
    Key? key,
    required this.username,
    required this.mobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile.jpeg'),
          ),
          SizedBox(height: 20),
          Text(
            username,
            style: TextStyle(
              color: Color(0XFF005653),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          Text(
            mobile,
            style: TextStyle(
              color: Color(0XFF005653),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ProfileListView extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileListView({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(horizontal: 40).copyWith(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0XFF005653),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 30, color: Colors.white),
            SizedBox(width: 25),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              size: 25,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}