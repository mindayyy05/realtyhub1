import 'package:flutter/material.dart';

class AgencyDetailPage2 extends StatelessWidget {
  const AgencyDetailPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agency Name 2'), // Replace with actual agency name
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
        backgroundColor: Colors.teal, // Change app bar color
      ),
      body: SingleChildScrollView( // Allows for scrolling if content is too long
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/realestateagency2.png', // Replace with your agency logo
                    height: 150, // Adjust the height as necessary
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Agency Name 2', // Replace with actual agency name
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // Change text color
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Short description about Agency 2. This agency is known for its commitment to finding the best caregivers for children and adults alike. Their professionals are trained and vetted for your peace of mind.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // Change text color
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Phone: (987) 654-3210',
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                'Email: agency2@example.com',
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                'Website: www.agency2.com',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Action to book or contact the agency
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Contact Agency',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
