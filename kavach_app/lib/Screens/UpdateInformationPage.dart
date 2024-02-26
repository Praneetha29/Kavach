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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              CustomizedTextField(
                myController: _fullNameController,
                hintText: 'Full Name',
                isPassword: false,
                submitted: true,
                prefixIcon: Icon(Icons.person),
              ),
              CustomizedTextField(
                myController: _emailController,
                hintText: 'Email',
                isPassword: false,
                submitted: true,
                prefixIcon: Icon(Icons.email),
              ),
              CustomizedTextField(
                myController: _mobileController,
                hintText: 'Mobile Number',
                isPassword: false,
                submitted: true,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: Icon(Icons.phone),
              ),
              CustomizedTextField(
                myController: _emergencyContact1Controller,
                hintText: 'Emergency Contact Number 1',
                isPassword: false,
                submitted: true,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: Icon(Icons.phone),
              ),
              CustomizedTextField(
                myController: _emergencyContact2Controller,
                hintText: 'Emergency Contact Number 2',
                isPassword: false,
                submitted: true,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: Icon(Icons.phone),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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