import 'package:flutter/material.dart';

class PropertyPage3 extends StatelessWidget {
  const PropertyPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          PropertyCard3(),
          PropertyCard3(), // Add more PropertyCard widgets as needed
        ],
      ),
    );
  }
}

class PropertyCard3 extends StatefulWidget {
  const PropertyCard3({Key? key}) : super(key: key);

  @override
  _PropertyCard3State createState() => _PropertyCard3State();
}

class _PropertyCard3State extends State<PropertyCard3> {
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

  Widget _buildHeartIcon() {
    return Container(
      width: 24,
      height: 24,
      child: Icon(
        Icons.favorite_border,
        size: 24,

      ),
    );
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
                'assets/images/1storyhouseWgarden.jpeg',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'House with a Garden',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildHeartIcon(),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'for sale',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rs. 800,000',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildInfoBox(Icons.bed, '2 bed rooms'),
                          SizedBox(width: 8), // Add spacing between the boxes
                          _buildInfoBox(Icons.bathtub, '2 bath rooms'),
                          SizedBox(width: 8), // Add spacing between the boxes
                          _buildInfoBox(Icons.garage, '0 garages'),
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
                          _buildDetailRow('Property ID', '156'),
                          _buildDivider(),
                          _buildDetailRow('First price', 'Rs.800,000'),
                          _buildDivider(),
                          _buildDetailRow('Second price', 'Rs.20,000/sq ft'),
                          _buildDivider(),
                          _buildDetailRow('Property type', 'House'),
                          if (_showMoreDetails) ...[
                            _buildDivider(),
                            _buildDetailRow('Real Estate Agent', 'realtors&co'),
                            _buildDivider(),
                            _buildDetailRow('Phone number', '0714333223'),
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
                      'Discover the charm of this beautiful one-story house at 233/2, Hyde Park Avenue, Colombo 3. Nestled in a peaceful neighborhood, this residence features a huge garden adorned with palm trees, creating a serene oasis in the city. The home is equipped with modern amenities, including air conditioning, Wi-Fi, a TV, and solar panels, ensuring both comfort and sustainability. With its inviting atmosphere and practical living spaces, this property offers the perfect retreat for those seeking tranquility and convenience.',
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
                      '233/2, Hyde Park Avenue, Colombo 3',
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

