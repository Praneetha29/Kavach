import 'package:flutter/material.dart';
import 'package:kavach_app/widgets/customized_button.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFF005653), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_sharp),
                        onPressed: () {
                          Navigator.pop(context);
                        })),
              ),
              const Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Get back to your safety bud,\nKavach!",
                    style: TextStyle(
                      color: Color(0XFF005653),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              CustomizedTextField(
                myController: _emailController,
                hintText: "Enter your email",
                isPassword: false,
              ),
              CustomizedTextField(
                myController: _passwordController,
                hintText: "Enter your password",
                isPassword: true,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Forgot Password?",
                  style: TextStyle(
                    color: Color(0XFF005653),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
                ),
              ),
              CustomizedButton(
                buttonText: "Login",
                buttonColor: const Color(0XFF005653),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
              ),
              SizedBox(
                height: 240,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                  style: TextStyle(
                    color: Color(0xff6a707c),
                    fontSize: 15,
                  ),),
                  Text("Sign Up",
                  style: TextStyle(
                    color: Color(0XFF005653),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
