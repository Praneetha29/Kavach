import 'package:flutter/material.dart';

class CustomizedTextField extends StatelessWidget {
  final TextEditingController myController;
  
  const CustomizedTextField({super.key, required this.myController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: myController,
        decoration: InputDecoration(
          fillColor: Color(0xffE8ECF4),
          filled: true,
          hintText: "Enter your email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
