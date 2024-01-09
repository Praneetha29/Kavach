import 'package:flutter/material.dart';

class FormValidation extends StatelessWidget {
  final String inputText;
  final String validationType;
  final String? confirmPassword;

  const FormValidation(
      {super.key,
      // Key? key,
      required this.inputText,
      required this.validationType,
      this.confirmPassword});

  String? _validateMobile(String mobile) {
    if (mobile.isEmpty) {
      return "Mobile number cannot be empty!";
    } else if (mobile.length < 10) {
      return "Too short!";
    } else if (mobile.length > 10) {
      return "Invalid Number";
    } else {
      return null;
    }
  }

  String? _validateUsername(String username) {
    if (username.isEmpty) {
      return "Username cannot be empty!";
    } else {
      return null;
    }
  }

  String? _validatePassword(String password) {
    if (password.length < 8) {
      return "Password is too short!";
    } else {
      return null;
    }
  }

  String? _validateConfirmPassword(String password, String? confirmPassword) {
    if (password.compareTo(confirmPassword!) != 0) {
      return "Passwords do not match!";
    } else {
      return null;
    }
  }

  String? getErrorMessages() {
    String? errorText;

    if (validationType == "mobile") {
      errorText = _validateMobile(inputText);
    } else if (validationType == "username") {
      errorText = _validateUsername(inputText);
    } else if (validationType == "password") {
      errorText = _validatePassword(inputText);
    } else if (validationType == "confirm-password") {
      errorText = _validateConfirmPassword(inputText, confirmPassword);
    }

    return errorText;
  }

  @override
  Widget build(BuildContext context) {
    return Text(getErrorMessages()!);
  }
}
