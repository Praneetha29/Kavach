import 'package:flutter/material.dart';
class AddContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
        backgroundColor: Color(0XFF005653), // Set the app bar color
      ),
      body: Center(
        child: Text('Add Contact Page'),
      ),
    );
  }
}