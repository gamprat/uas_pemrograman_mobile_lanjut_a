import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavouriteModel with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  FavouriteModel() {
    _loadFromPrefs();
  }

  List<Map<String, dynamic>> get items => _items;

  void addItem(String title, String imagePath, double price) {
    final item = {'title': title, 'imagePath': imagePath, 'price': price};
    _items.add(item);
    _saveToPrefs();
    notifyListeners();
  }

  void removeItem(String title) {
    _items.removeWhere((item) => item['title'] == title);
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('favourites', json.encode(_items));
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedItems = prefs.getString('favourites');
    if (savedItems != null) {
      _items = List<Map<String, dynamic>>.from(json.decode(savedItems));
    }
    notifyListeners();
  }
}
