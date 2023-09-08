import 'package:flutter/material.dart';
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
            margin: EdgeInsets.only(top: 60),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/home_illus.jpg"),
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image(
                  image: AssetImage("assets/app_logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 35),
              CustomizedButton(
                buttonText: "Login",
                buttonColor: Color(0XFF005653),
                textColor: Colors.white,
                onPressed: () {},
              ),
              SizedBox(height: 2),
              CustomizedButton(
                buttonText: "Register",
                buttonColor: Colors.white,
                textColor: Color(0XFF005653),
                onPressed: () {},
              ),
              SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
