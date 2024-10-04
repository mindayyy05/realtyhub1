import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> addFeedback(String name, String feedback) async {
    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/feedback');
      var request = http.MultipartRequest('POST', url);

      request.fields['name'] = name;
      request.fields['feedback'] = feedback;

      var response = await request.send();
      if (response.statusCode == 200) {
        print('Feedback added successfully');
      } else {
        print('Failed to add feedback');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _feedback() {
    var name = _nameController.text;
    var feedback = _feedbackController.text;

    // Call the function to add the feedback
    addFeedback(
      name,
      feedback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFcfd9df), Color(0xFFe2ebf0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center( // Use Center to align the card in the middle of the screen
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Add your feedback'),
                      const SizedBox(height: 20),
                      _buildTextField('Your Name', _nameController, Icons.person, 'Enter your name'),
                      const SizedBox(height: 20),
                      _buildTextField('Your Feedback', _feedbackController, Icons.feedback, 'Add your feedback'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _feedback,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          backgroundColor: Colors.blueAccent,
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: const Center(child: Text('Submit Feedback')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController? controller,
      IconData icon,
      String hintText, {
        bool isDropdown = false,
        List<String>? dropdownItems,
        String? selectedValue,
        ValueChanged<String?>? onChanged,
      }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
