import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key});

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
          const Text(
            'Priya Patel',
            style: TextStyle(
                color: Color(0XFF005653),
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 5),
          const Text(
            '123456789',
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
                ),
                ProfileListView(
                  text: 'History',
                ),
                ProfileListView(
                  text: 'Update Information',
                ),
                ProfileListView(
                  text: 'Add Contact',
                ),
                ProfileListView(
                  text: 'Change Password',
                ),
                ProfileListView(
                  text: 'Log Out',
                  hasNavigation: false,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileListView extends StatelessWidget {
  final text;
  final bool hasNavigation;

  const ProfileListView({
    super.key,
    this.text,
    this.hasNavigation = true,
  });

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

    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
      ).copyWith(
        bottom: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0XFF005653),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
          const SizedBox(
            width: 25,
          ),
          Text(
            this.text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300),
          ),
          const Spacer(),
          if (this.hasNavigation)
            const Icon(
              LineAwesomeIcons.angle_right,
              size: 25,
              color: Colors.white,
            )
        ],
      ),
    );
  }
}
