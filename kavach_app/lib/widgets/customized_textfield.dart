import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for FilteringTextInputFormatter

class CustomizedTextField extends StatelessWidget {
  final TextEditingController myController;
  final String? hintText;
  final bool? isPassword;
  final List<TextInputFormatter>? inputFormatter; // Add this property

  const CustomizedTextField({
    Key? key,
    required this.myController,
    this.hintText,
    this.isPassword,
    this.inputFormatter, // Initialize it here
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        keyboardType: isPassword!
            ? TextInputType.visiblePassword
            : TextInputType.phone, // Use TextInputType.phone for mobile number
        inputFormatters: inputFormatter, // Apply the input formatter
        enableSuggestions: isPassword! ? false : true,
        autocorrect: isPassword! ? false : true,
        obscureText: isPassword ?? true,
        controller: myController,
        decoration: InputDecoration(
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
        ),
      ),
    );
  }
}
