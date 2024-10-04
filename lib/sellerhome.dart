import 'package:flutter/material.dart';

class SellerHomePage extends StatelessWidget {
  const SellerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Home'),
      ),
      body: Center(
        child: const Text(
          'Welcome to the Seller Home Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
