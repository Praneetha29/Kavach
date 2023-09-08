import 'package:flutter/material.dart';
import 'package:kavach_app/Screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kavach',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

