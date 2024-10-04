import 'package:flutter/material.dart';

class AgencyCard4 extends StatelessWidget {
  final VoidCallback onTap;

  const AgencyCard4({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: 180, // Set the card height
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView( // Allow scrolling in case of overflow

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Agency image or logo
                Image.asset(
                  'assets/images/realestateagency4.png',
                  height: 70, // Adjust image height as needed
                ),
                const SizedBox(height: 8),
                const Text(
                  'Connor Hamilton', // Replace with dynamic name
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '', // Add more details here if needed
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
