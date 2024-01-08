import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kavach_app/Screens/login_screen.dart';
import 'package:kavach_app/Screens/otp_form.dart';
import 'package:kavach_app/Screens/welcome_screen.dart';
import 'package:kavach_app/widgets/customized_button.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';
import 'package:kavach_app/widgets/form_validation.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _mobileController = TextEditingController();

  bool submitted = false;

  String? get mobileErrorText {
    final mobileText = _mobileController.value.text;
    FormValidation validator =
        FormValidation(inputText: mobileText, validationType: "mobile");
    return validator.getErrorMessages();
  }

  void forgot() {
    setState(() => submitted = true);
    if (mobileErrorText == null) {
      print("Password Reset!!!");
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const OtpForm()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ValueListenableBuilder(
          valueListenable: _mobileController,
          builder: (context, value, child) {
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
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0XFF005653),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        "Don't worry it occurs to us all. We will send you a link to reset your password.",
                        style: TextStyle(
                          color: Color(0xff6a707c),
                          fontSize: 16,
                        )),
                  ),
                  CustomizedTextField(
                    myController: _mobileController,
                    hintText: "Enter your mobile number",
                    errorText: mobileErrorText,
                    isPassword: false,
                    submitted: submitted,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  CustomizedButton(
                    buttonText: "Send code",
                    buttonColor: Color(0XFF005653),
                    textColor: Colors.white,
                    onPressed: forgot,
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
                          "Remember Password? ",
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
                ]);
          },
        ),
      ),
    ));
  }
}
