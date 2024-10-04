import 'package:flutter/foundation.dart';

class Listing {
  final int id;
  final String title;
  final String description;
  final String address;
  final List<String> images;

  Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.images,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'] ?? 0, // Default to 0 if null
      title: json['title'] ?? '', // Default to empty string if null
      description: json['description'] ?? '', // Default to empty string if null
      address: json['address'] ?? '', // Default to empty string if null
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [], // Handle null and empty list
    );
  }
}
