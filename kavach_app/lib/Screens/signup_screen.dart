import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kavach_app/Database/config.dart';
import 'package:kavach_app/Screens/login_screen.dart';
import 'package:kavach_app/Screens/welcome_screen.dart';
import 'package:kavach_app/widgets/customized_button.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';
import 'package:kavach_app/widgets/form_validation.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool submitted = false;

  String? get mobileErrorText {
    final mobileText = _mobileController.value.text;
    FormValidation validator =
    FormValidation(inputText: mobileText, validationType: "mobile");
    return validator.getErrorMessages();
  }

  String? get passwordErrorText {
    final passwordText = _passwordController.value.text;
    FormValidation validator =
    FormValidation(inputText: passwordText, validationType: "password");
    return validator.getErrorMessages();
  }

  String? get usernameErrorText {
    final usernameText = _usernameController.value.text;
    FormValidation validator =
    FormValidation(inputText: usernameText, validationType: "username");
    return validator.getErrorMessages();
  }

  String? get confirmPasswordErrorText {
    final passwordText = _passwordController.value.text;
    final confirmPasswordText = _confirmPasswordController.value.text;
    FormValidation validator = FormValidation(
        inputText: confirmPasswordText,
        confirmPassword: passwordText,
        validationType: "confirm-password");
    return validator.getErrorMessages();
  }

  Future signup() async {
    setState(() => submitted = true);
    if ((mobileErrorText == null) &&
        (usernameErrorText == null) &&
        (passwordErrorText == null) &&
        (confirmPasswordErrorText == null)) {
      var registerBody = {
        "mobile": _mobileController.value.text,
        "username": _usernameController.value.text,
        "password": _passwordController.value.text
      };

      try {
        var res = await http.post(Uri.parse(registerAPI),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(registerBody));

        var response = jsonDecode(res.body);

        if (res.statusCode == 200) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const LoginScreen()));
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Done',
            text: response['message'],
          );
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error...',
            text: 'Registration failed. Try again.',
          );
        }
      } catch (e) {
        inspect(e);
      }
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error...',
        text: 'Enter all the details properly',
      );
    }
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      border: Border.all(
                          color: const Color(0XFF005653), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_sharp),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => WelcomeScreen()));
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
                  errorText: mobileErrorText,
                  isPassword: false,
                  submitted: submitted,
                  inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                ),
                CustomizedTextField(
                  myController: _usernameController,
                  hintText: "Give your username",
                  errorText: usernameErrorText,
                  isPassword: false,
                  submitted: submitted,
                ),
                CustomizedTextField(
                  myController: _passwordController,
                  hintText: "Enter your password",
                  errorText: passwordErrorText,
                  isPassword: true,
                  submitted: submitted,
                ),
                CustomizedTextField(
                  myController: _confirmPasswordController,
                  hintText: "Confirm your password",
                  errorText: confirmPasswordErrorText,
                  isPassword: true,
                  submitted: submitted,
                ),
                CustomizedButton(
                  buttonText: "Sign Up",
                  buttonColor: const Color(0XFF005653),
                  textColor: Colors.white,
                  onPressed: () {
                    signup();
                  },
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()));
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}