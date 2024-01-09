import 'package:flutter/material.dart';
import 'package:kavach_app/widgets/customized_button.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Color(0XFF005653), // Set the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomizedTextField(
              myController: oldPasswordController,
              hintText: 'Old Password',
              isPassword: true,
              submitted: true,
            ),
            SizedBox(height: 16),
            CustomizedTextField(
              myController: newPasswordController,
              hintText: 'New Password',
              isPassword: true,
              submitted: true,
            ),
            SizedBox(height: 16),
            CustomizedTextField(
              myController: confirmNewPasswordController,
              hintText: 'Confirm New Password',
              isPassword: true,
              submitted: true,
            ),
            SizedBox(height: 16),
            CustomizedButton(
              buttonText: 'Set Password',
              buttonColor: Color(0XFF005653),
              textColor: Colors.white,
              onPressed: () {
                // Add your logic here for setting the password
                // You can access oldPasswordController.text, newPasswordController.text, and confirmNewPasswordController.text for user input
              },
            ),
          ],
        ),
      ),
    );
  }
}
