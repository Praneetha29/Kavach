import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:kavach_app/Database/config.dart';
import 'package:kavach_app/Screens/AddContactPage.dart';
import 'package:kavach_app/widgets/customized_button.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:kavach_app/Screens/google_auth_api.dart';

class UpdateInformationPage extends StatefulWidget {
  final String? initialFullName;
  final String? initialMobile;

  const UpdateInformationPage({
    Key? key,
    this.initialFullName,
    this.initialMobile,
  }) : super(key: key);

  @override
  _UpdateInformationPageState createState() => _UpdateInformationPageState();
}

class _UpdateInformationPageState extends State<UpdateInformationPage> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _emergencyContact1Controller;
  late TextEditingController _emergencyContact2Controller;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.initialFullName);
    _emailController = TextEditingController();
    _mobileController = TextEditingController(text: widget.initialMobile);
    _emergencyContact1Controller = TextEditingController();
    _emergencyContact2Controller = TextEditingController();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid name.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || !EmailValidator.validate(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.length != 10) {
      return 'Mobile number must be 10 digits long.';
    }
    return null;
  }

  String? validateEmergencyContact(String? value) {
    if (value == null || value.isEmpty || value.length != 10) {
      return 'Emergency contact must be 10 digits long.';
    }
    return null;
  }

  Future<void> updateUserProfile() async {
    if (_validateForm()) {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final Map<String, dynamic> updatedProfileData = {
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'mobile': _mobileController.text,
        'emergencyContact1': _emergencyContact1Controller.text,
        'emergencyContact2': _emergencyContact2Controller.text,
      };

      final response = await http.put(
        Uri.parse(userProfileAPI),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(updatedProfileData),
      );

      if (response.statusCode == 200) {
        try {
          final decodedResponse = json.decode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')),
          );
          // ... Handle successful response ...
        } catch (e) {
          // This means there was an error parsing the response as JSON
          // Handle the JSON parsing error
        }
      } else {
        // Non-200 Response (e.g., error from the server)
        // Handle non-200 responses here without attempting to parse as JSON
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: ${response.body}')),
        );
      }
    }
  }

  bool _validateForm() {
    final nameValid = validateName(_fullNameController.text) == null;
    final emailValid = validateEmail(_emailController.text) == null;
    final mobileValid = validateMobile(_mobileController.text) == null;
    final emergencyContact1Valid = validateEmergencyContact(_emergencyContact1Controller.text) == null;
    final emergencyContact2Valid = validateEmergencyContact(_emergencyContact2Controller.text) == null;

    if (!nameValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid name.')),
      );
      return false;
    } else if (!emailValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address.')),
      );
      return false;
    } else if (!mobileValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mobile number must be 10 digits long.')),
      );
      return false;
    } else if (!emergencyContact1Valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Emergency Contact 1 must be 10 digits long.')),
      );
      return false;
    } else if (!emergencyContact2Valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Emergency Contact 2 must be 10 digits long.')),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Information'),
        backgroundColor: Color(0XFF005653),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: TextStyle(
                  fontWeight: FontWeight.w500, // Medium font weight
                  fontSize: 18,
                  color: Colors.grey[800],
                  // Dark grey color
                ),
              ),
              CustomizedTextField(
                myController: _fullNameController,
                hintText: "As per your Driver's License",
                isPassword: false,
                submitted: true,
                prefixIcon: Icon(Icons.person),
              ),
              Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.w500, // Medium font weight
                  fontSize: 18,
                  color: Colors.grey[800],
                  // Dark grey color
                ),
              ),
              CustomizedTextField(
                myController: _emailController,
                hintText: 'abc@gmail.com',
                isPassword: false,
                submitted: true,
                prefixIcon: Icon(Icons.email),
              ),
              Text(
                'Mobile Number',
                style: TextStyle(
                  fontWeight: FontWeight.w500, // Medium font weight
                  fontSize: 18,
                  color: Colors.grey[800],
                  // Dark grey color
                ),
              ),
              CustomizedTextField(
                myController: _mobileController,
                hintText: 'Should be 10 digits',
                isPassword: false,
                submitted: true,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: Icon(Icons.phone),
              ),
              Text(
                'Emergency Contact Number 1',
                style: TextStyle(
                  fontWeight: FontWeight.w500, // Medium font weight
                  fontSize: 18,
                  color: Colors.grey[800],
                  // Dark grey color
                ),
              ),
              CustomizedTextField(
                myController: _emergencyContact1Controller,
                hintText: 'Should be 10 digits',
                isPassword: false,
                submitted: true,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: Icon(Icons.phone),
              ),
              Text(
                'Emergency Contact Number 2',
                style: TextStyle(
                  fontWeight: FontWeight.w500, // Medium font weight
                  fontSize: 18,
                  color: Colors.grey[800],
                  // Dark grey color
                ),
              ),
              CustomizedTextField(
                myController: _emergencyContact2Controller,
                hintText: 'Should be 10 digits',
                isPassword: false,
                submitted: true,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: Icon(Icons.phone),
              ),

              SizedBox(height: 8),
              CustomizedButton(
                buttonText: 'Add Contacts',
                buttonColor: Colors.white,
                borderColor: Color(0XFF005653),
                textColor: Color(0XFF005653),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddContactPage()),
                  );
                },
              ),
              SizedBox(height: 6),
              CustomizedButton(
                buttonText: 'Save',
                buttonColor: Color(0XFF005653),
                textColor: Colors.white,
                onPressed: () async {
    if (_validateForm()) {
    // Sign-in to Google when saving
    final GoogleSignInAccount? googleUser = await GoogleAuthApi.signIn();
    if (googleUser != null && googleUser.email == _emailController.text) {
    final auth = await googleUser.authentication;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', googleUser.email);
    await prefs.setString('accessToken', auth.accessToken!);

    // Once signed in, and tokens are stored, then save user profile data
    updateUserProfile();
    }
    }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _emergencyContact1Controller.dispose();
    _emergencyContact2Controller.dispose();
    super.dispose();
  }
}