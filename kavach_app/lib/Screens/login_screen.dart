import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kavach_app/Screens/map_screen.dart';
import 'package:kavach_app/Screens/welcome_screen.dart';
import 'package:kavach_app/screens/signup_screen.dart';
import 'package:kavach_app/screens/forgot_password.dart';
import 'package:kavach_app/widgets/customized_button.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';
import 'package:kavach_app/widgets/form_validation.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

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

  void login() {
  setState(() => submitted = true); // we need to implement the user auth here

  if (_mobileController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
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
        body: Container(
          height: MediaQuery.of(context).size.height,
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
                          ),
                          CustomizedTextField(
                            myController: _passwordController,
                            hintText: "Enter your password",
                            errorText: passwordErrorText,
                            isPassword: true,
                            submitted: submitted,
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
                          Spacer(
                            flex: 1,
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
    );
  }
}
