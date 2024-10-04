import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'propertyinfo.dart';
import 'providers/liked_properties_provider.dart'; // Import your provider

class LikePage extends StatelessWidget {
  const LikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the LikedPropertiesProvider
    final likedPropertiesProvider = Provider.of<LikedPropertiesProvider>(context);
    final likedProperties = likedPropertiesProvider.likedProperties; // Get the liked properties

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Properties'),
      ),
      body: likedProperties.isEmpty
          ? const Center(child: Text('No liked properties yet'))
          : ListView.builder(
        itemCount: likedProperties.length,
        itemBuilder: (context, index) {
          final property = likedProperties[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Card(
              child: ListTile(
                leading: Image.network(property['images'][0], fit: BoxFit.cover, width: 100),
                title: Text(property['title'] ?? 'No Title'),
                subtitle: Text('Rs. ${property['price']}'),
                onTap: () {
                  // Navigate to PropertyInfoPage for the liked property
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyInfoPage(listing: property),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
