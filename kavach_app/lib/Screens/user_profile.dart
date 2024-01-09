import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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
  const UserProfile({Key? key, required this.token});

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
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(414, 896),
    );

    var profileInfo = Container(
      padding: const EdgeInsets.only(left: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.only(top: 30),
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.jpeg'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: const Color(0XFF005653),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LineAwesomeIcons.pen,
                      color: Colors.white,
                      size: ScreenUtil().setSp(15),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0XFF005653),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LineAwesomeIcons.sun,
                      size: ScreenUtil().setSp(30),
                      color: const Color.fromARGB(255, 167, 166, 166),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            username,
            style: TextStyle(
                color: Color(0XFF005653),
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 5),
          Text(
            mobile,
            style: TextStyle(
                color: Color(0XFF005653),
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );

    var header = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(width: 30),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0XFF005653), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_sharp),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        profileInfo,
      ],
    );
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          header,
          Expanded(
            child: ListView(
              children: <Widget>[
                ProfileListView(
                  text: 'Home',
                  icon: LineAwesomeIcons.home,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen())),
                ),
                ProfileListView(
                  text: 'History',
                  icon: LineAwesomeIcons.history,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewHistoryPage())),
                ),
                ProfileListView(
                  text: 'Update Information',
                  icon: LineAwesomeIcons.user_edit,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateInformationPage())),
                ),
                ProfileListView(
                  text: 'Add Contact',
                  icon: LineAwesomeIcons.user_plus,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage())),
                ),
                ProfileListView(
                  text: 'Change Password',
                  icon: LineAwesomeIcons.lock,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage())),
                ),
                // Include other navigation items using the same pattern...
                ProfileListView(
                  text: 'Log Out',
                  icon: LineAwesomeIcons.alternate_sign_out, // Defined icon parameter
                  onTap: () {
                    // Include logout functionality here...
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileListView extends StatelessWidget {
  final String text;
  final IconData icon; // Define the icon parameter here
  final VoidCallback onTap; // Define onTap as a VoidCallback

  const ProfileListView({
    Key? key,
    required this.text,
    required this.icon, // Make sure to require the icon parameter
    required this.onTap, // Make sure to require the onTap parameter
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final iconMap = {
      'Home': LineAwesomeIcons.home,
      'History': LineAwesomeIcons.history,
      'Update Information': LineAwesomeIcons.user_edit,
      'Add Contact': LineAwesomeIcons.user_plus,
      'Change Password': LineAwesomeIcons.lock,
      'Log Out': LineAwesomeIcons.alternate_sign_out,
    };

    final icon = iconMap[text];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0XFF005653),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(width: 25),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
            ),
            const Spacer(),
            const Icon(
              LineAwesomeIcons.angle_right,
              size: 25,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
