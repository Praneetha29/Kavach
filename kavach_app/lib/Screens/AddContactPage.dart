import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';
import 'package:kavach_app/widgets/customized_button.dart';

class AddContactPage extends StatelessWidget {
  // Consider If the controllers need to be disposed, switch to a StatefulWidget and override dispose().
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Add key to constructor
 AddContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contact'), // const added for performance
        backgroundColor: const Color(0XFF005653), // const added for performance
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // const added for performance
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomizedTextField(
              myController: nameController,
              hintText: 'Name',
              isPassword: false,
              submitted: true,
              prefixIcon: Icon(Icons.person),
            ),
            const SizedBox(height: 16), // const added for performance
            CustomizedTextField(
              myController: phoneController,
              hintText: 'Phone',
              isPassword: false,
              submitted: true,
              prefixIcon: Icon(Icons.phone),
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            const SizedBox(height: 16), // const added for performance
            CustomizedTextField(
              myController: emailController,
              hintText: 'Email',
              isPassword: false,
              submitted: true,
              prefixIcon: Icon(Icons.email),
            ),
            const SizedBox(height: 16), // const added for performance
            CustomizedButton(
              buttonText: 'Add Contact',
              buttonColor: const Color(0XFF005653), // const added for performance
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
