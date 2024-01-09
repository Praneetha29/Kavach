import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kavach_app/Screens/user_profile.dart';
import 'package:kavach_app/Screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString("token")));
}

class MyApp extends StatefulWidget {
  final token;
  const MyApp({@required this.token, Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kavach',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0XFF005653),
      ),
      home:
          (widget.token != null && JwtDecoder.isExpired(widget.token) == false)
              ? UserProfile(token: widget.token)
              : const WelcomeScreen(),
    );
  }
}
