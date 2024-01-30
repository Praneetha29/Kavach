import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kavach_app/Screens/map_screen.dart';

import 'package:kavach_app/Database/config.dart';
import 'package:kavach_app/Screens/user_profile.dart';

import 'package:kavach_app/Screens/welcome_screen.dart';
import 'package:kavach_app/screens/signup_screen.dart';
import 'package:kavach_app/screens/forgot_password.dart';
import 'package:kavach_app/widgets/customized_button.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';
import 'package:kavach_app/widgets/form_validation.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  late SharedPreferences prefs;

  bool submitted = false;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

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

  void login() async {
    setState(() => submitted = true);
    final mobileText = _mobileController.value.text;
    final passwordText = _passwordController.value.text;
    if (mobileText.isNotEmpty && passwordText.isNotEmpty && mobileErrorText == null && passwordErrorText == null) {
      var loginBody = {
        "mobile": mobileText,
        "password": passwordText
      };
      try {
        var res = await http.post(Uri.parse(loginAPI),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(loginBody));
        var response = jsonDecode(res.body);
        inspect(res);
        if (res.statusCode == 200) {
          var authToken = response['token'];
          prefs.setString("token", authToken);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => UserProfile(token: authToken)));
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Done',
            text: "Logged in successfully.",
          );
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error...',
            text: 'Login failed. Try again.',
          );
        }
      } catch (e) {
        inspect(e);
      }
    } else if (mobileText.isEmpty || passwordText.isEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MapScreen()));
    }
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
           
            width: double.infinity,
            child: ValueListenableBuilder(
                valueListenable: _mobileController,
                builder: (context, TextEditingValue value, __) {
                  return ValueListenableBuilder(
                      valueListenable: _passwordController,
                      builder: (context, TextEditingValue value, __) {
                        return Column(
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
                                "Logging Back In:\nKavach's Safety Shield",
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
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.phone,
                            ),
                            CustomizedTextField(
                              myController: _passwordController,
                              hintText: "Enter your password",
                              errorText: passwordErrorText,
                              isPassword: true,
                              submitted: submitted,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ForgotPassword()));
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color(0XFF005653),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CustomizedButton(
                              buttonText: "Login",
                              buttonColor: const Color(0XFF005653),
                              textColor: Colors.white,
                              onPressed: login,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
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
                                              builder: (_) =>
                                              const SignUpScreen()));
                                    },
                                    child: const Text(
                                      "Sign up Now",
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
                        );
                      });
                }),
          ),
        ),
      ),
    );
  }
}