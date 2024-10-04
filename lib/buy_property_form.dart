import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'success.dart'; // Import your success.dart file here

class BuyPropertyForm extends StatefulWidget {
  final String propertyId;
  final String price;

  const BuyPropertyForm({Key? key, required this.propertyId, required this.price}) : super(key: key);

  @override
  _BuyPropertyFormState createState() => _BuyPropertyFormState();
}

class _BuyPropertyFormState extends State<BuyPropertyForm> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryMonthController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();

  Future<void> makeTransaction(
      String cardNumber,
      String expiryMonth,
      String cvv,
      String cardName,
      String propertyId,
      String price,
      ) async {
    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/pay');
      var request = http.MultipartRequest('POST', url);

      request.fields['cardNumber'] = cardNumber;
      request.fields['expiryMonth'] = expiryMonth;
      request.fields['cvv'] = cvv;
      request.fields['cardName'] = cardName;
      request.fields['property_id'] = propertyId;
      request.fields['price'] = price;

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('Payment successful');
        // Navigate to SuccessPage on successful payment
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SuccessPage()));
      } else {
        print('Failed to pay: $responseBody'); // Log the response for debugging
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _pay() {
    var cardNumber = _cardNumberController.text;
    var expiryMonth = _expiryMonthController.text;
    var cvv = _cvvController.text;
    var cardName = _cardNameController.text;

    makeTransaction(cardNumber, expiryMonth, cvv, cardName,
        widget.propertyId, widget.price
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make your payment'),
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
                    _buildSectionTitle('Payment information'),

                    const SizedBox(height: 20),
                    _buildTextField('Card Number', _cardNumberController, Icons.credit_card, 'Enter card number'),
                    const SizedBox(height: 20),
                    _buildTextField('Expiry Month', _expiryMonthController, Icons.date_range, 'Enter expiry month'),
                    const SizedBox(height: 20),
                    _buildTextField('CVV', _cvvController, Icons.security, 'Enter CVV'),
                    const SizedBox(height: 20),
                    _buildTextField('Card Name', _cardNameController, Icons.person, 'Enter cardholder name'),

                    const SizedBox(height: 20),

                    Text('Property ID: ${widget.propertyId}', style: const TextStyle(fontSize: 18)),
                    Text('Price: ${widget.price}', style: const TextStyle(fontSize: 18, color: Colors.green)),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pay,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        backgroundColor: Colors.blueAccent,
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Center(child: Text('Submit Payment')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController? controller, IconData icon, String hintText) {
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
