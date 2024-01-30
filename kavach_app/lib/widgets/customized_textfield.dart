import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomizedTextField extends StatelessWidget {
  final TextEditingController myController;
  final String? hintText;
  final String? errorText;
  final bool? isPassword;
  final bool? submitted;
  final List<TextInputFormatter>? inputFormatter; // Add this property
  final Icon? prefixIcon; // Updated prefixIcon to be an Icon widget
  final TextInputType? keyboardType; // Allow specifying keyboardType

  const CustomizedTextField({
    Key? key,
    required this.myController,
    this.hintText,
    this.errorText,
    this.isPassword,
    this.submitted,
    this.inputFormatter,
    this.prefixIcon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        keyboardType:
        isPassword! ? TextInputType.visiblePassword : TextInputType.text,
        inputFormatters: inputFormatter,
        enableSuggestions: isPassword! ? false : true,
        autocorrect: isPassword! ? false : true,
        obscureText: isPassword ?? true,
        controller: myController,
        decoration: InputDecoration(
          prefixIcon: prefixIcon, // Use the prefixIcon if provided
          suffixIcon: isPassword!
              ? IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove_red_eye, color: Color(0xff183535)),
          )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff018677), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: const Color(0xff99cec8),
          filled: true,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorText: submitted! ? errorText : null,
        ),
      ),
    );
  }
}