import 'package:flutter/material.dart';

class PropertyPage2 extends StatelessWidget {
  const PropertyPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          PropertyCard2(),
          PropertyCard2(), // Add more PropertyCard widgets as needed
        ],
      ),
    );
  }
}

class PropertyCard2 extends StatefulWidget {
  const PropertyCard2({Key? key}) : super(key: key);

  @override
  _PropertyCard2State createState() => _PropertyCard2State();
}

class _PropertyCard2State extends State<PropertyCard2> {
  bool _showMoreDetails = false;
  bool _showMoreFeatures = false;

  void _toggleDetails() {
    setState(() {
      _showMoreDetails = !_showMoreDetails;
    });
  }

  void _toggleFeatures() {
    setState(() {
      _showMoreFeatures = !_showMoreFeatures;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // Make each card fit the screen width
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/twostoryhouse.jpeg',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Two Story House',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.favorite_border,
                      size: 24,

                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'for rent',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rs. 200,000/month',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildInfoBox(Icons.bed, '3 bed rooms'),
                          SizedBox(width: 8), // Add spacing between the boxes
                          _buildInfoBox(Icons.bathtub, '2 bath rooms'),
                          SizedBox(width: 8), // Add spacing between the boxes
                          _buildInfoBox(Icons.garage, '1 garage'),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: _toggleDetails,
                          child: Text(
                            'more details',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Property ID', '98'),
                          _buildDivider(),
                          _buildDetailRow('First price', 'Rs.200,000/month'),
                          _buildDivider(),
                          _buildDetailRow('Property type', 'House'),
                          if (_showMoreDetails) ...[
                            _buildDivider(),
                            _buildDetailRow('Real Estate Agent', 'Find Your Home'),
                            _buildDivider(),
                            _buildDetailRow('Phone number', '0703003116'),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Features',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: _toggleFeatures,
                          child: Text(
                            'more features',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeatureIcon(Icons.ac_unit, 'AC'),
                        _buildFeatureIcon(Icons.tv, 'TV'),
                        _buildFeatureIcon(Icons.wifi, 'WiFi'),
                        _buildFeatureIcon(Icons.pool, 'Pool'),
                      ],
                    ),
                    if (_showMoreFeatures) ...[
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildFeatureIcon(Icons.local_fire_department, 'Fireplace'),
                          _buildFeatureIcon(Icons.local_parking, 'Parking'),
                          _buildFeatureIcon(Icons.kitchen, 'Kitchen'),
                          _buildFeatureIcon(Icons.spa, 'Spa'),
                        ],
                      ),
                    ],
                    SizedBox(height: 16),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Discover the charm of this inviting two-story residence at 8/A, Park Road, Colombo 5. Built with comfort in mind, this home features built-in heaters and air conditioning throughout, ensuring year-round comfort. Boasting three bedrooms and two bathrooms, this cozy abode offers ample space for family living. Additional highlights include a spacious garage for convenient parking and storage, as well as a dedicated dog kennel for your furry companions. Located in a prime neighborhood, this home is designed to blend modern amenities with practical living, offering the perfect retreat in the heart of the city.',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '8/A, Park Road, Colombo 5',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String text) {
    return Container(
      width: 120, // Adjust the width of each box as needed
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.lightBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12, // Adjust the font size of the text
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 1,
      color: Colors.grey, // Make the divider color a solid grey for better visibility
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.lightBlue.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

