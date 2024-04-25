import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartModel with ChangeNotifier {
  Map<int, int> _items = {};

  Map<int, int> get items => _items;

  void addItem(int productId) {
    if (_items.containsKey(productId)) {
      _items[productId] = _items[productId]! + 1;
      print('Incremented item quantity: $productId');
    } else {
      _items[productId] = 1;
    }
    notifyListeners();
    saveCartToPreferences();
  }

  void subtractItem(int productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]! > 1) {
        _items[productId] = _items[productId]! - 1;
      } else {
        _items.remove(productId);
      }
      notifyListeners();
      saveCartToPreferences();
    }
  }

  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
    saveCartToPreferences();
  }

  void changeQuantity(int productId, int quantity) {
    if (quantity > 0) {
      _items[productId] = quantity;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
    saveCartToPreferences();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
    saveCartToPreferences();
  }


  int get totalItems => _items.values
      .fold(0, (previousValue, element) => previousValue + element);

  Future<void> loadCartFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String? cartItemsString = prefs.getString('cartItems');
    if (cartItemsString != null) {
      Map<String, dynamic> jsonMap = json.decode(cartItemsString);
      _items = jsonMap.map((key, value) => MapEntry(int.parse(key), value as int));
    }
    notifyListeners();
  }

  Future<void> saveCartToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, int> stringKeyMap = _items.map((key, value) => MapEntry(key.toString(), value));
    await prefs.setString('cartItems', json.encode(stringKeyMap));
  }
}
