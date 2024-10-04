// listing.dart
class Listing {
  final String title;
  final String description;
  final String price;

  Listing({required this.title, required this.description, required this.price});

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      title: json['title'],
      description: json['description'],
      price: json['price'],
    );
  }
}
