import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(String title, String imagePath, double price, int quantity) {
    int index = _items.indexWhere((item) => item['title'] == title);

    if (index >= 0) {
      _items[index]['quantity'] += quantity;
    } else {
      _items.add({
        'title': title,
        'imagePath': imagePath,
        'price': price,
        'quantity': quantity,
      });
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    _items[index]['quantity'] = quantity;
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(
        0, (total, item) => total + item['price'] * item['quantity']);
  }
}
