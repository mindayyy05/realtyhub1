import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({Key? key}) : super(key: key);

  @override
  _UserDashboardPageState createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  List listings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchListings();
  }

  // Function to fetch listings from the Laravel API
  Future<void> fetchListings() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/listingsdash'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        listings = data['data'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load listings');
    }
  }

  String _getImageUrl(Map listing) {
    return (listing['images'] != null && listing['images'].isNotEmpty)
        ? listing['images'][0]
        : 'assets/images/placeholder.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Top horizontal bar for navigation
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
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
                // Left: Listed Properties
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.list, color: Colors.blue, size: 30),
                      const SizedBox(height: 5),
                      Text(
                        'Listed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ],
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
                        Icon(Icons.shopping_cart, color: Colors.black54, size: 30),
                        const SizedBox(height: 5),
                        const Text(
                          'Bought',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
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
                      // Navigate to the Sold Properties page
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
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Main body content with fetched listings
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : listings.isEmpty
              ? const Center(child: Text('No listings available'))
              : Expanded(
            child: ListView.builder(
              itemCount: listings.length,
              itemBuilder: (context, index) {
                final listing = listings[index];
                String imageUrl = _getImageUrl(listing);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      // Handle card tap if needed
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: imageUrl.startsWith('http')
                                      ? NetworkImage(imageUrl)
                                      : AssetImage(imageUrl) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listing['title'] ?? 'No Title',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      if (listing['is_for_sale'] == 1) _statusTag('For Sale'),
                                      if (listing['is_for_rent'] == 1) _statusTag('For Rent'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, color: Colors.blueAccent, size: 20),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          listing['address'] ?? 'No Address',
                                          style: const TextStyle(fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  _detailsRow(listing),
                                  const SizedBox(height: 8),
                                  Text(
                                    '\$${listing['price']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
      ),
    );
  }

  Widget _detailsRow(Map listing) {
    return Row(
      children: [
        const Icon(Icons.bed, color: Colors.blueAccent, size: 20),
        const SizedBox(width: 4),
        Text('${listing['bedrooms']} beds', style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 16),
        const Icon(Icons.bathtub, color: Colors.blueAccent, size: 20),
        const SizedBox(width: 4),
        Text('${listing['bathrooms']} baths', style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 16),
        const Icon(Icons.local_parking, color: Colors.blueAccent, size: 20),
        const SizedBox(width: 4),
        Text('${listing['garages']} ', style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
