import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kavach_app/Database/config.dart'; // Contains the serverURL and API paths
import 'package:kavach_app/Screens/AddContactPage.dart';
import 'package:kavach_app/widgets/customized_button.dart';
import 'package:kavach_app/widgets/customized_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

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


  Future<void> updateUserProfile() async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      final errorResponse = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: ${errorResponse['message']}')),
      );
    }
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
                onPressed: updateUserProfile,
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