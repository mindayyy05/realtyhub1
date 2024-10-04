import 'package:flutter/material.dart';
import 'buy_property_form.dart'; // Import the new form page
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart'; // Import share_plus package
import 'like.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For encoding data
import 'package:shared_preferences/shared_preferences.dart';



// Add the districtCoordinates map here
Map<String, LatLng> districtCoordinates = {
  'Colombo': LatLng(6.9271, 79.8612),
  'Galle': LatLng(6.0535, 80.2200),
  'Jaffna': LatLng(9.6615, 80.0255),
  'Kandy': LatLng(7.2906, 80.6337),
  'Trincomalee': LatLng(8.5874, 81.2152),
  'Ampara': LatLng(7.2928, 81.6746),
  'Anuradhapura': LatLng(8.3114, 80.4037),
  'Badulla': LatLng(6.9897, 81.0561),
  'Batticaloa': LatLng(7.7170, 81.6824),
  'Gampaha': LatLng(7.0910, 79.9993),
  'Hambantota': LatLng(6.1248, 81.1185),
  'Kalutara': LatLng(6.5854, 79.9607),
  'Kegalle': LatLng(7.2513, 80.3464),
  'Kilinochchi': LatLng(9.3803, 80.3998),
  'Kurunegala': LatLng(7.4818, 80.3609),
  'Mannar': LatLng(8.9817, 79.9042),
  'Matale': LatLng(7.4699, 80.6215),
  'Matara': LatLng(5.9485, 80.5353),
  'Monaragala': LatLng(6.8724, 81.3452),
  'Nuwara Eliya': LatLng(6.9497, 80.7891),
  'Polonnaruwa': LatLng(7.9403, 81.0188),
  'Puttalam': LatLng(8.0305, 79.8392),
  'Ratnapura': LatLng(6.6828, 80.3995),
  'Vavuniya': LatLng(8.7546, 80.4982),
};




class PropertyInfoPage extends StatefulWidget { // Change to StatefulWidget
   // Colombo, Sri Lanka
  final Map<String, dynamic> listing;

  PropertyInfoPage({Key? key, required this.listing}) : super(key: key);


  @override
  _PropertyInfoPageState createState() => _PropertyInfoPageState();
}

class _PropertyInfoPageState extends State<PropertyInfoPage> {
  bool _showMoreDetails = false; // State variable to control expansion
  bool _isLiked = false; // Track if the property is liked
  bool _isFavourite = false;
  List<Map<String, dynamic>> likedProperties = []; // Global or shared state for liked properties


  void _addToLikedProperties(Map<String, dynamic> property) {
    likedProperties.add(property); // Add property to liked list
  }

  void _removeFromLikedProperties(Map<String, dynamic> property) {
    likedProperties.removeWhere((item) => item['id'] == property['id']); // Remove property
  }
  Future<void> likeProperty(bool isFavourite) async {
    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/like');
      var request = http.MultipartRequest('POST', url);

      // Send the property ID and the favourite status
      request.fields['is_favourite'] = isFavourite ? '1' : '0';
      request.fields['listing_id'] = widget.listing['id'].toString(); // Send property ID

      var response = await request.send();
      if (response.statusCode == 200) {
        // Handle successful response
        print('Property liked successfully');
      } else {
        // Handle error
        print('Failed to like property');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  void _like() {
    // Call the function to list the property
    likeProperty(_isFavourite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listing['title'] ?? 'Property Details'),
      ),
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? _buildPortraitLayout(context)
          : _buildLandscapeLayout(context),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPropertyImage(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    _buildPrice(),
                    const SizedBox(height: 16),
                    _buildDetailsRow(),
                    const SizedBox(height: 16),
                    _buildDetailsSection(),
                    const SizedBox(height: 16),
                    _buildExpandableDetails(),
                    const SizedBox(height: 16),
                    _buildFeaturesSection(),
                    const SizedBox(height: 16),
                    _buildDescription(),
                    const SizedBox(height: 16),
                    _buildAddress(),
                    const SizedBox(height: 16),
                    _buildMap(),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text('Add to Favourite'),
                      value: _isFavourite,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFavourite = value ?? false;
                          _like(); // Call the like function to send the updated status
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildBuyButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fixed Image on the Left Side
        Container(
          width: MediaQuery.of(context).size.width * 0.4, // Adjust width as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPropertyImage(), // Your method for displaying the property image
              const SizedBox(height: 8), // Space between image and title
              _buildTitle(), // Title below image (kept from the left side)
            ],
          ),
        ),
        // Scrollable Details on the Right Side
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row for Title and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildTitle()), // Title below image (kept from the left side)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0), // Space between title and price
                        child: Text(
                          '\$${widget.listing['price'] ?? 'N/A'}', // Display price on the right
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // Additional spacing
                  _buildDetailsRow(),
                  const SizedBox(height: 16),
                  _buildDetailsSection(),
                  const SizedBox(height: 16),
                  _buildExpandableDetails(),
                  const SizedBox(height: 16),
                  _buildFeaturesSection(),
                  const SizedBox(height: 16),
                  _buildDescription(),
                  const SizedBox(height: 16),
                  _buildAddress(),
                  const SizedBox(height: 16),
                  _buildMap(),
                  const SizedBox(height: 16),
                  // Checkbox for favorite
                  CheckboxListTile(
                    title: const Text('Add to Favourite'),
                    value: _isFavourite,
                    onChanged: (bool? value) {
                      setState(() {
                        _isFavourite = value ?? false;
                        _like(); // Call the like function to send the updated status
                      });
                    },
                  ),
                  const SizedBox(height: 16), // Optional spacing
                  _buildBuyButton(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }





  Widget _buildPropertyImage() {
    List<dynamic> images = _getImages(); // Retrieve the list of images
    if (images.isEmpty) {
      return Center(child: Text('No Images Available')); // Handle no images scenario
    }

    return SizedBox(
      height: 250, // Set the height for the image container
      child: PageView.builder(
        itemCount: images.length, // Number of images to display
        itemBuilder: (context, index) {
          return Image.network(
            'http://10.0.2.2:8000/66fff106552a1.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
          );
        },
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.listing['title'] ?? 'No Title',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            color: _isLiked ? Colors.pink : Colors.grey,
          ),
          onPressed: () async {
            setState(() {
              _isLiked = !_isLiked;
            });


          },
        ),

        IconButton(
          icon: Icon(Icons.share),
          onPressed: _shareProperty,
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Text(
      'Rs. ${widget.listing['price']}',
      style: const TextStyle(fontSize: 20, color: Colors.blue),
    );
  }

  Widget _buildDetailsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildInfoBox(Icons.bed, '${widget.listing['bedrooms']} Bedrooms'),
          const SizedBox(width: 8),
          _buildInfoBox(Icons.bathtub, '${widget.listing['bathrooms']} Bathrooms'),
          const SizedBox(width: 8),
          _buildInfoBox(Icons.garage, '${widget.listing['garages']} Garages'),
        ],
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String text) {
    return Container(
      width: 120,
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
            style: const TextStyle(fontSize: 12, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    final String propertyId = widget.listing['id'].toString();
    final String firstPrice = 'Rs. ${widget.listing['price']}';
    final String secondPrice = 'Rs. ${widget.listing['price']}';
    final String propertyType = widget.listing['property_type'] ?? 'N/A';
    final String agent = widget.listing['real_estate_agent'] ?? 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Details', style: TextStyle(fontSize: 18, color: Colors.grey)),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showMoreDetails = !_showMoreDetails; // Update the state
                });
              },
              child: Text('More Details', style: TextStyle(fontSize: 14, color: Colors.blue)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildDetailRow('Property ID', propertyId),
              _buildDivider(),
              _buildDetailRow('First Price', firstPrice),
              _buildDivider(),
              _buildDetailRow('Second Price', secondPrice),
              _buildDivider(),
              _buildDetailRow('Property Type', propertyType),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildExpandableDetails() {
    final String agent = widget.listing['real_estate_agent'] ?? 'N/A'; // Move this line here
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        if (_showMoreDetails) ...[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Real Estate Agent', agent), // Use the local variable here
                _buildDivider(),
                _buildDetailRow('Phone Number', widget.listing['phone'] ?? 'N/A'),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onBackground)), // Use adaptive color
          Text(value, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onBackground)), // Use adaptive color
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildFeaturesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Features', style: const TextStyle(fontSize: 18, color: Colors.grey)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFeatureIcon(Icons.ac_unit, 'AC'),
            _buildFeatureIcon(Icons.tv, 'TV'),
            _buildFeatureIcon(Icons.wifi, 'WiFi'),
            _buildFeatureIcon(Icons.pool, 'Pool'),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.blue)),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: const TextStyle(fontSize: 18, color: Colors.grey)),
        Text(widget.listing['description'] ?? 'N/A'),
      ],
    );
  }

  Widget _buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Address:', style: const TextStyle(fontSize: 18, color: Colors.grey)),
        Text(widget.listing['address'] ?? 'N/A'),
      ],
    );
  }

  Widget _buildBuyButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          // Retrieve user ID from shared preferences
          final prefs = await SharedPreferences.getInstance();
          final int userId = prefs.getInt('userId') ?? -1; // Assuming -1 indicates an unknown user

          // Ensure userId is valid before proceeding
          if (userId == -1) {
            // Handle the error, e.g., show a message to the user
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User not logged in')),
            );
            return; // Exit the function if userId is invalid
          }

          // Extract property ID and price from listing
          String propertyId = widget.listing['id'].toString();
          String price = 'Rs. ${widget.listing['price']}';

          // Navigate to BuyPropertyForm and pass propertyId and price
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BuyPropertyForm(
                propertyId: propertyId, // Pass property ID
                price: price, // Pass price
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Set the background color to blue
        ),
        child: const Text(
          'Buy Property',
          style: TextStyle(
            color: Colors.white, // Set the font color to white
          ),
        ),
      ),
    );
  }

  List<dynamic> _getImages() {
    if (widget.listing['images'] is String) {
      return json.decode(widget.listing['images']);
    } else if (widget.listing['images'] is List) {
      return widget.listing['images'];
    } else {
      return [];
    }
  }

  static const CameraPosition _initialCameraPosition =
  CameraPosition(target: LatLng(6.9271, 79.9619), zoom: 14);
  Widget _buildMap() {
    String state = widget.listing['state'] ?? 'Unknown'; // Retrieve the state/district

    if (districtCoordinates.containsKey(state)) {
      // If the state is found in the district map, show the map
      LatLng coordinates = districtCoordinates[state]!;

      return SizedBox(
        height: 300,
        width: double.infinity,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: coordinates, // Use the coordinates from the map
            zoom: 12,
          ),
          markers: {
            Marker(
              markerId: MarkerId('propertyLocation'),
              position: coordinates,
            ),
          },
        ),
      );
    } else {
      // If the state is not found, show a message
      return Center(
        child: Text(
          'Map not found for this place',
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }
  }


  void _shareProperty() {
    final String title = widget.listing['title'] ?? 'Property Details';
    final String price = 'Rs. ${widget.listing['price']}';
    final String address = widget.listing['address'] ?? 'No address provided';
    final String description = widget.listing['description'] ?? 'No description available';

    final String shareContent = 'Check out this property:\n\n'
        'Title: $title\n'
        'Price: $price\n'
        'Address: $address\n'
        'Description: $description\n\n'
        'Contact us for more details!';

    Share.share(shareContent);
  }



}