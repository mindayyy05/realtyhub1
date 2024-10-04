import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package
import 'home.dart'; // Replace with actual import path for home.dart
import 'like.dart'; // Replace with actual import path for like.dart
import 'search.dart'; // Replace with actual import path for search.dart


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _profilePhotoUrl = ''; // New variable to store profile photo URL
  final String baseUrl = 'http://10.0.2.2:8000/'; // Change this to your actual base URL

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Load profile data when the page initializes
  }

  // Method to load saved profile data from SharedPreferences
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'Mindi Chenaya'; // Default name if not found
      _email = prefs.getString('email') ?? 'mindi.chenaya@gmail.com'; // Default email if not found
      _phoneNumber = prefs.getString('phoneNumber') ?? '+94-703-003-116'; // Default phone number if not found
      String photoPath = prefs.getString('profile_photo_path') ?? ''; // Get profile photo path from SharedPreferences
      _profilePhotoUrl = photoPath.isNotEmpty ? baseUrl + photoPath : ''; // Construct full URL
    });
  }

  // Method to save edited profile data
  Future<void> _saveProfileData(String name, String email, String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phoneNumber', phoneNumber);

    setState(() {
      _name = name;
      _email = email;
      _phoneNumber = phoneNumber;
    });
  }

  // Method to show edit profile dialog
  void _showEditProfileDialog() {
    TextEditingController nameController = TextEditingController(text: _name);
    TextEditingController emailController = TextEditingController(text: _email);
    TextEditingController phoneController = TextEditingController(text: _phoneNumber);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveProfileData(nameController.text, emailController.text, phoneController.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profilePhotoUrl.isNotEmpty
                    ? NetworkImage(_profilePhotoUrl) // Use NetworkImage if URL is available
                    : const AssetImage('assets/images/mindi.jpeg') as ImageProvider, // Default image
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                _name,
                style: const TextStyle(
                  fontSize: 20, // Headline size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Profile Information',
              style: TextStyle(
                fontSize: 18, // Subtitle size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),
            _buildProfileInfo(Icons.email_outlined, 'Email', _email), // Display retrieved email
            const SizedBox(height: 8),
            _buildProfileInfo(Icons.phone_android_outlined, 'Phone Number', _phoneNumber), // Display retrieved phone number
            const SizedBox(height: 8),
            _buildProfileInfo(Icons.home_outlined, 'Address', 'No.7, Ivy Park, Hokandara Road, Thalawathu...'), // Using grey icon
            const SizedBox(height: 24),
            const Text(
              'Property Statistics',
              style: TextStyle(
                fontSize: 18, // Subtitle size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),
            _buildStatInfo(Icons.list_alt, 'Properties Listed', '5'), // Using grey icon
            const SizedBox(height: 8),
            _buildStatInfo(Icons.sell_outlined, 'Properties Sold', '3'), // Using grey icon
            const SizedBox(height: 8),
            _buildStatInfo(Icons.shopping_cart_outlined, 'Properties Bought', '1'), // Using grey icon
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _showEditProfileDialog,
                child: const Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, 0, false),
            label: '', // Empty label
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.favorite, 1, false),
            label: '', // Empty label
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.search, 2, false),
            label: '', // Empty label
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, 3, true), // Set true for profile to have grey background
            label: '', // Empty label
          ),
        ],
        currentIndex: 3, // Assuming profile is at index 3
        selectedItemColor: Colors.blueAccent, // Set the selected item color to blueAccent
        unselectedItemColor: Colors.blueAccent, // Set the unselected item color to blueAccent
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyHomePage()));
              break;
            case 1:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LikePage()));
              break;
            case 2:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SearchPage()));
              break;
            default:
              break;
          }
        },
      ),
    );
  }

  Widget _buildProfileInfo(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.grey, // Grey color for profile icons
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$label: ',
                style: const TextStyle(
                  fontSize: 16, // Body text size
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16, // Body text size
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatInfo(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.grey, // Grey color for stats icons
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$label: ',
                style: const TextStyle(
                  fontSize: 16, // Body text size
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16, // Body text size
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index, bool isProfile) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isProfile ? Colors.grey[300] : Colors.transparent, // Add grey background for the profile icon
      ),
      child: Icon(icon),
    );
  }
}
