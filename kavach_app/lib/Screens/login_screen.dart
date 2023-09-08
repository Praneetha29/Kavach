import 'package:flutter/material.dart';

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
              TextField()
            ],
          ),
        ),
      ),
    );
  }
}
