import 'package:flutter/material.dart';
import 'package:kavach_app/Screens/login_screen.dart';
import 'package:kavach_app/Screens/signup_screen.dart';
import 'package:kavach_app/widgets/customized_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/home_illus.jpg"),
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 100,
                width: 100,
                child: Image(
                  image: AssetImage("assets/app_logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 35),
              CustomizedButton(
                buttonText: "Login",
                buttonColor: const Color(0XFF005653),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
              ),
              const SizedBox(height: 2),
              CustomizedButton(
                buttonText: "Register",
                buttonColor: Colors.white,
                borderColor: Color(0XFF005653),
                textColor: const Color(0XFF005653),
                onPressed: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()));
                
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
