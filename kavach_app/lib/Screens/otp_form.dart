import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kavach_app/Screens/login_screen.dart';
import 'package:kavach_app/Screens/user_profile.dart';
import 'package:kavach_app/screens/forgot_password.dart';
import 'package:kavach_app/widgets/customized_button.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ForgotPassword()),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.only(left:16.0),
                child: Text(
                  "Verification",
                  style: TextStyle(
                    color: Color(0XFF005653),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0), 
                child: Text(
                  "Enter the verification code",
                  style: TextStyle(
                    color: Color(0xff6a707c),
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 68,
                      width: 64,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF005653), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          onSaved: (pin1) {},
                          decoration: const InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 68,
                      width: 64,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF005653), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextFormField(
                          onSaved: (pin2) {},
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 68,
                      width: 64,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF005653), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextFormField(
                          onSaved: (pin3) {},
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 68,
                      width: 64,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF005653), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextFormField(
                          onSaved: (pin4) {},
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.headlineSmall,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              CustomizedButton(
                buttonText: "Verify",
                buttonColor: Color(0XFF005653),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UserProfile()));
                },
              ),
              
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Din't recieve any code ",
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
                          "Resend Code",
                          style: TextStyle(
                            color: Color(0XFF005653),
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
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
    );
  }
}
