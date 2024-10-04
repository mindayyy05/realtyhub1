import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add the image here
            Image.asset(
              'assets/images/img_3.png', // Path to your image
              height: 150, // You can adjust the height and width as needed
              width: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Your purchase was successful!',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
