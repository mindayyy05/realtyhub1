import 'package:flutter/material.dart';
import 'signup.dart'; // Import the signup page
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'home.dart'; // Import the home page
import 'sellerhome.dart'; // Import the seller home page
import 'adminhome.dart'; // Import the admin home page
import 'package:uuid/uuid.dart'; // Import the uuid package

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    var email = _emailController.text;
    var password = _passwordController.text;

    // Generate a unique token
    var uuid = Uuid();
    String token = uuid.v4(); // Generate a new token

    Loginuser(email, password, token);
  }

  void _goToSignUp() {
    // Navigate to sign up page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Kept alignment at start
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100), // Adjusted top padding

              // Logo and text
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/realtyhubb.jpeg',
                      height: 120,
                      width: 120,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Please enter your login details',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Email field
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              // Password field
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              // Login button
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Set background color to blue
                  foregroundColor: Colors.white, // Set text color to white
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Login', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 16),
              // Sign up text
              Center(
                child: GestureDetector(
                  onTap: _goToSignUp,
                  child: const Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void Loginuser(String email, String password, String token) async {
    var url = Uri.parse("http://10.0.2.2:8000/api/login");

    // Send HTTP POST request with the token
    var response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
        'token': token, // Include the generated token
      },
    );

    // Print the response status and body
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Check if the response is successful
    if (response.statusCode == 200) {
      // Parse the JSON response
      var responseData = jsonDecode(response.body);

      // Extract user data and token from the response
      var user = responseData['user'];
      // Optionally retrieve the Sanctum token if needed
      String sanctumToken = responseData['sanctum_token'];

      // Print the tokens to the terminal
      print('Sanctum Token: $sanctumToken');
      print('Token sent: $token');

      // Extract user information
      int userId = user['id'];
      String name = user['name'];
      String email = user['email'];
      String phoneNumber = user['phoneNumber'];
      int userRole = user['user_role'];

      // Print user data to verify
      print('User ID: $userId');
      print('Name: $name');
      print('Email: $email');
      print('Phone Number: $phoneNumber');
      print('User Role: $userRole');

      // Store user data and tokens in local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', userId);
      await prefs.setString('name', name);
      await prefs.setString('email', email);
      await prefs.setString('phoneNumber', phoneNumber);
      await prefs.setInt('userRole', userRole);
      await prefs.setString('sanctumToken', sanctumToken); // Store the Sanctum token if needed
      await prefs.setString('token', token); // Store the token sent from Flutter

      // Retrieve userId from SharedPreferences
      int? retrievedUserId = prefs.getInt('userId');

      if (retrievedUserId == null) {
        String? userIdString = prefs.getString('userId');
        if (userIdString != null) {
          retrievedUserId = int.tryParse(userIdString);
        }
      }

      // Navigate to the appropriate home page based on user role
      if (userRole == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      } else if (userRole == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SellerHomePage()),
        );
      } else if (userRole == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomePage()),
        );
      }
    } else {
      // Handle the case where login fails
      print('User not logged in');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }
}
