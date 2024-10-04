import 'package:flutter/material.dart';

class LikedPropertiesProvider with ChangeNotifier {
  List<Map<String, dynamic>> _likedProperties = [];

  List<Map<String, dynamic>> get likedProperties => _likedProperties;

  void addProperty(Map<String, dynamic> property) {
    _likedProperties.add(property);
    notifyListeners(); // Notify listeners of state change
  }

  void removeProperty(Map<String, dynamic> property) {
    _likedProperties.removeWhere((item) => item['id'] == property['id']);
    notifyListeners(); // Notify listeners of state change
  }
}
