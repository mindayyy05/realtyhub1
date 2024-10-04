import 'package:flutter/material.dart';
import 'profile.dart';
import 'property.dart';
import 'property2.dart';
import 'property3.dart';
import 'search.dart';
import 'like.dart';
import 'sell.dart'; // Import the Sell page
import 'featured_property_card.dart';
import 'featured_property_card2.dart';
import 'featured_property_card3.dart';
import 'cards.dart';
import 'rent.dart';
import 'sale.dart';
import 'apartment.dart';
import 'real_estate_agency_card.dart';
import 'real_estate_agency_card2.dart';
import 'real_estate_agency_card3.dart';
import 'real_estate_agency_card4.dart'; // Add this line
import 'agency_detail_page_1.dart';
import 'agency_detail_page_2.dart';
import 'agency_detail_page_3.dart';
import 'agency_detail_page_4.dart';
import 'userdashboard.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: {
        '/profile': (context) => const ProfilePage(),
        '/property': (context) => const PropertyPage(),
        '/property2': (context) => const PropertyPage2(),
        '/property3': (context) => const PropertyPage3(),
        '/search': (context) => const SearchPage(),
        '/like': (context) => const LikePage(),
        '/sell': (context) => const SellPage(), // Add the route for Sell page
        '/cards': (context) => const CardsPage(), // Add the route for Cards page
        '/rent': (context) => const RentPage(), // Add the Rent page route
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _selectedDistrict = 'Colombo';

  final List<String> _districts = [
    'Colombo',
    'Gampaha',
    'Kalutara',
    'Kandy',
    'Matale',
    'Nuwara Eliya',
    'Galle',
    'Matara',
    'Hambantota',
    'Jaffna',
    'Kilinochchi',
    'Mannar',
    'Vavuniya',
    'Mullaitivu',
    'Batticaloa',
    'Ampara',
    'Trincomalee',
    'Kurunegala',
    'Puttalam',
    'Anuradhapura',
    'Polonnaruwa',
    'Badulla',
    'Moneragala',
    'Ratnapura',
    'Kegalle'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/like');
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserDashboardPage()), // Navigate to userdashboard.dart
        );
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
      default:
        break;
    }
  }


  void _navigateToSell() {
    Navigator.pushNamed(context, '/sell');
  }

  void _navigateToProperty() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const PropertyPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToProperty2() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const PropertyPage2(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToProperty3() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const PropertyPage3(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToAgency1() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AgencyDetailPage1()), // Replace with your actual agency detail page
    );
  }

  void _navigateToAgency2() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AgencyDetailPage2()), // Replace with your actual agency detail page
    );
  }

  void _navigateToAgency3() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AgencyDetailPage3()), // Replace with your actual agency detail page
    );
  }

  void _navigateToAgency4() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AgencyDetailPage4()), // Replace with your actual agency detail page
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Current Location',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.blueAccent,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    DropdownButton<String>(
                      value: _selectedDistrict,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blueAccent,
                        size: 27,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDistrict = newValue!;
                        });
                      },
                      items: _districts
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface, // Change text color based on theme
                            ),
                          ),
                        );
                      }).toList(),
                      underline: Container(), // Remove underline
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
                width: 8), // Add some space between the text and icon
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Add your menu functionality here
              },
            ),
          ],
        ),
      ),
      body: OrientationBuilder( // <--- Added OrientationBuilder
        builder: (context, orientation) {
          // Determine layout based on orientation
          if (orientation == Orientation.portrait) {
            return _buildPortraitLayout(); // <--- Added function for portrait layout
          } else {
            return _buildLandscapeLayout(); // <--- Added function for landscape layout
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, 0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.favorite, 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.dashboard, 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, 3),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }

// New method to build the portrait layout
  Widget _buildPortraitLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cards'); // Navigate to cards.dart
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Buy',
                  style: TextStyle(fontSize: 14), // Button text size
                ),
              ),
              const SizedBox(width: 8), // Add some space between the buttons
              ElevatedButton(
                onPressed: _navigateToSell, // Navigate to sell page
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  'Sell',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What are you looking for?',
                  style: TextStyle(
                    fontSize: 16, // Subhead text size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/rent'); // Navigate to rent.dart
                        },
                        child: _buildIconCircle(Icons.home, 'For Rent'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/sale'); // Navigate to rent.dart
                        },
                        child: _buildIconCircle(Icons.attach_money, 'For Sale'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/apartment'); // Navigate to rent.dart
                        },
                        child: _buildIconCircle(Icons.apartment, 'Apartments'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/commercial'); // Navigate to rent.dart
                        },
                        child: _buildIconCircle(Icons.business, 'Commercial'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/townhouse'); // Navigate to rent.dart
                        },
                        child: _buildIconCircle(Icons.house, 'Townhouses'),
                      ),
                      _buildIconCircle(Icons.local_activity, 'Rental Spaces'),
                      _buildIconCircle(Icons.weekend, 'Vacational Rentals'),
                    ],
                  ),
                ),
                const SizedBox(
                    height: 20), // Add space between icon row and text
                const Text(
                  'Featured Properties',
                  style: TextStyle(
                    fontSize: 16, // Subhead text size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FeaturedPropertyCard(onTap: _navigateToProperty),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'Latest properties in Colombo',
              style: TextStyle(
                fontSize: 16, // Subhead text size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FeaturedPropertyCard2(onTap: _navigateToProperty2),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'Featured Agencies',
              style: TextStyle(
                fontSize: 16, // Subhead text size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Use a GridView to display the AgencyCards
          SizedBox(
            height: 200, // Adjust height as needed
            child: GridView.count(
              crossAxisCount: 2, // 2 columns
              mainAxisSpacing: 16.0, // Space between rows
              crossAxisSpacing: 16.0, // Space between columns
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              children: [
                AgencyCard(onTap: _navigateToAgency1), // Agency Card 1
                AgencyCard2(onTap: _navigateToAgency2), // Agency Card 2
                AgencyCard3(onTap: _navigateToAgency3), // Agency Card 3
                AgencyCard4(onTap: _navigateToAgency4), // Agency Card 4
              ],
            ),
          ),
        ],
      ),
    );
  }

// New method to build the landscape layout
  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cards'); // Navigate to cards.dart
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Buy',
                        style: TextStyle(fontSize: 14), // Button text size
                      ),
                    ),
                    const SizedBox(width: 8), // Add some space between the buttons
                    ElevatedButton(
                      onPressed: _navigateToSell, // Navigate to sell page
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Sell',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What are you looking for?',
                        style: TextStyle(
                          fontSize: 16, // Subhead text size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Center the icon row
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/rent'); // Navigate to rent.dart
                                },
                                child: _buildIconCircle(Icons.home, 'For Rent'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/sale'); // Navigate to sale.dart
                                },
                                child: _buildIconCircle(Icons.attach_money, 'For Sale'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/apartment'); // Navigate to apartment.dart
                                },
                                child: _buildIconCircle(Icons.apartment, 'Apartments'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/commercial'); // Navigate to commercial.dart
                                },
                                child: _buildIconCircle(Icons.business, 'Commercial'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/townhouse'); // Navigate to townhouse.dart
                                },
                                child: _buildIconCircle(Icons.house, 'Townhouses'),
                              ),
                              _buildIconCircle(Icons.local_activity, 'Rental Spaces'),
                              _buildIconCircle(Icons.weekend, 'Vacational Rentals'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Featured Properties',
                        style: TextStyle(
                          fontSize: 16, // Subhead text size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FeaturedPropertyCard(onTap: _navigateToProperty),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Latest properties in Colombo',
                          style: TextStyle(
                            fontSize: 16, // Subhead text size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FeaturedPropertyCard2(onTap: _navigateToProperty2),
                      const SizedBox(height: 20),
                      // Move agency cards here
                      const Text(
                        'Featured Agencies',
                        style: TextStyle(
                          fontSize: 16, // Subhead text size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Use spaceEvenly to distribute evenly
                        children: [
                          Expanded(child: AgencyCard(onTap: _navigateToAgency1)), // Agency Card 1
                          Expanded(child: AgencyCard2(onTap: _navigateToAgency2)), // Agency Card 2
                          Expanded(child: AgencyCard3(onTap: _navigateToAgency3)), // Agency Card 3
                          Expanded(child: AgencyCard4(onTap: _navigateToAgency4)), // Agency Card 4
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }








  Widget _buildIconCircle(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.lightBlue[100], // Light blue background color
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.blueAccent, // Blue icon color
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Icon(
        icon,
        size: 30,
        color: _selectedIndex == index ? Colors.blueAccent : Colors.grey,
      ),
    );
  }
}
