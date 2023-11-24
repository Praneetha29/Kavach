import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';
import 'package:kavach_app/widgets/customized_button.dart';

class AddContactPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contact'),
        backgroundColor: Color(0XFF005653), // Set the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomizedTextField(
              myController: nameController,
              hintText: 'Name',
              isPassword: false,
              submitted: true,
            ),
            SizedBox(height: 16),
            CustomizedTextField(
              myController: phoneController,
              hintText: 'Phone',
              isPassword: false,
              submitted: true,
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            SizedBox(height: 16),
            CustomizedButton(
              buttonText: 'Add Contact',
              buttonColor: Color(0XFF005653),
              textColor: Colors.white,
              onPressed: () {
                // Add your logic here for adding contact
                // You can access nameController.text and phoneController.text for user input
              },
            ),
          ],
        ),
      ),
    );
  }
}
