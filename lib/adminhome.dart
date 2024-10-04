import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: Center(
        child: const Text(
          'Welcome to the Admin Home Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
