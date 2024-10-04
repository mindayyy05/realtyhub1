import 'package:flutter/material.dart';

class AgencyDetailPage4 extends StatelessWidget {
  const AgencyDetailPage4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connor Hamilton Agency'), // Replace with actual agency name
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/realestateagency4.png', // Replace with your agency logo
              height: 150, // Adjust the height as necessary
            ),
            const SizedBox(height: 16),
            const Text(
              'Agency Name 1', // Replace with actual agency name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Short description about Agency 1. This agency specializes in providing top-notch services for caretakers and babysitters. Their experienced staff is dedicated to helping you find the right match for your needs.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Phone: (123) 456-7890',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Email: agency1@example.com',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Website: www.agency1.com',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Action to book or contact the agency
              },
              child: const Text('Contact Agency'),
            ),
          ],
        ),
      ),
    );
  }
}
