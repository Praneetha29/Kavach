import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:kavach_app/Screens/login_screen.dart';
import 'package:kavach_app/Screens/welcome_screen.dart'; 
import 'package:kavach_app/widgets/customized_button.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _mobileController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController(); 

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        Navigator.push(context,
                          MaterialPageRoute(builder: (_) => WelcomeScreen()));
                    
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Secure your journey with Kavach",
                    style: TextStyle(
                      color: Color(0XFF005653),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomizedTextField(
                  myController: _mobileController,
                  hintText: "Enter your mobile number",
                  isPassword: false,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                CustomizedTextField(
                  myController: _usernameController,
                  hintText: "Give your username",
                  isPassword: false,
                ),
                CustomizedTextField(
                  myController: _passwordController,
                  hintText: "Enter your password",
                  isPassword: true,
                ),
                CustomizedTextField(
                  myController: _confirmPasswordController, 
                  hintText: "Confirm your password",
                  isPassword: true,
                ),
                CustomizedButton(
                  buttonText: "Sign Up",
                  buttonColor: const Color(0XFF005653),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Color(0xff6a707c),
                        fontSize: 15,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()));
                      },
                      child: const Text(
                        "Sign in Now",
                        style: TextStyle(
                          color: Color(0XFF005653),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
