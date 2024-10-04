import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'propertyinfo.dart';

class CommercialPage extends StatefulWidget {
  const CommercialPage({Key? key}) : super(key: key);

  @override
  _CommercialPageState createState() => _CommercialPageState();
}

class _CommercialPageState extends State<CommercialPage> {
  List listings = [];
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    fetchListings();
  }

  Future<void> fetchListings() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/commerciallistings');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          listings = jsonResponse['payload'].map((listing) {
            if (listing['images'] != null) {
              try {
                final imagePaths = json.decode(listing['images']);
                listing['images'] = imagePaths.map((path) {
                  return 'http://10.0.2.2:8000/api/commerciallistings';
                }).toList();
              } catch (e) {
                listing['images'] = [];
              }
            }
            return listing;
          }).toList();
          isLoading = false; // Set loading state to false
        });
      } else {
        throw Exception('Failed to load listings');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading state to false
      });
      print('Error fetching listings: $e');
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
        title: const Text('Listings'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : listings.isEmpty
          ? const Center(child: Text('No listings available'))
          : ListView.builder(
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final listing = listings[index];
          String imageUrl = _getImageUrl(listing);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PropertyInfoPage(listing: listing),
                  ),
                );
              },


              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
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
                          borderRadius: BorderRadius.circular(5),
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
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                _statusTag('Featured'),
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
        Flexible(
          child: Text(
            '${listing['garages']} garages',
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
