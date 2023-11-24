import 'package:flutter/material.dart';
import 'package:kavach_app/widgets/customized_button.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';
import 'package:flutter/services.dart';
import 'package:kavach_app/Screens/AddContactPage.dart';

class UpdateInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Information'),
        backgroundColor: Color(0XFF005653),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 50,
                // You can add the profile picture logic here
              ),
              SizedBox(height: 20),

              // Full Name
              _buildTextFieldWithHeading(
                heading: 'Full Name',
                hintText: 'John Doe',
              ),

              // Email
              _buildTextFieldWithHeading(
                heading: 'Email',
                hintText: 'john.doe@example.com',
              ),

              // Mobile Number
              _buildTextFieldWithHeading(
                heading: 'Mobile Number',
                hintText: '1234567890',
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),

              // Emergency Contact Number 1
              _buildTextFieldWithHeading(
                heading: 'Emergency Contact Number 1',
                hintText: '9876543210',
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),

              // Emergency Contact Number 2
              _buildTextFieldWithHeading(
                heading: 'Emergency Contact Number 2',
                hintText: '9876543211',
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),

              // Additional Contacts Button
              CustomizedButton(
                buttonText: 'Additional Contacts',
                buttonColor: Color(0XFF005653),
                textColor: Colors.white,
                onPressed: () {
                  // Navigate to the AddContactPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddContactPage()),
                  );
                },
              ),

              SizedBox(height: 20),

              // Save and Cancel Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomizedButton(
                    buttonText: 'Save',
                    buttonColor: Color(0XFF005653),
                    textColor: Colors.white,
                    onPressed: () {
                      // Handle save logic
                    },
                  ),
                  CustomizedButton(
                    buttonText: 'Cancel',
                    buttonColor: Colors.grey,
                    textColor: Colors.white,
                    onPressed: () {
                      // Handle cancel logic
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithHeading({
    required String heading,
    required String hintText,
    List<TextInputFormatter>? inputFormatter,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomizedTextField(
          myController: TextEditingController(text: hintText),
          hintText: heading,
          isPassword: false,
          submitted: true,
          inputFormatter: inputFormatter,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
