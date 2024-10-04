import 'package:flutter/material.dart';

class DashboardBoughtPage extends StatelessWidget {
  const DashboardBoughtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue, // Changed to blue theme
        elevation: 0, // Remove shadow for a cleaner look
      ),
      body: Column(
        children: [
          // Top horizontal bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            decoration: const BoxDecoration(
              color: Colors.white, // White background for the header
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, // Subtle shadow for 3D effect
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left: Listed Properties (Highlighted)
                Expanded(

            child: GestureDetector(
            onTap: () {
        // Navigate to the Bought Properties page
        Navigator.pushNamed(context, '/userdashboard');
  },

                  child: Column(
                    children: [
                      Icon(Icons.list, color: Colors.black54, size: 30),
                      const SizedBox(height: 5),
                      Text(
                        'Listed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                ),
                // Divider between Listed Properties and Bought Properties
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey[300], // Small grey line
                ),
                // Middle: Bought Properties
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the Bought Properties page
                      Navigator.pushNamed(context, '/dashboardBought');
                    },
                    child: Column(
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.blue, size: 30),
                        const SizedBox(height: 5),
                        const Text(
                          'Bought',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Divider between Bought Properties and Sold Properties
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey[300], // Small grey line
                ),
                // Right: Sold Properties
                Expanded(
                  child: GestureDetector(
                  onTap: () {
                  // Navigate to the Bought Properties page
                  Navigator.pushNamed(context, '/dashboardSold');
                  },

                  child: Column(
                    children: [
                      Icon(Icons.sell, color: Colors.black54, size: 30),
                      const SizedBox(height: 5),
                      const Text(
                        'Sold',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                ),
              ],

            ),
          ),
          const SizedBox(height: 20),
          // Main body content
          Expanded(
            child: Center(
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'your bought properties',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}