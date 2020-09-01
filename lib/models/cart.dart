import 'package:flutter/material.dart';

class CartItem {
  String itemId;
  Image imageUrl;
  String itemName;
  int quantity;
  double rate;
  double total;

  CartItem({
    this.itemId,
    this.imageUrl,
    this.itemName,
    this.quantity,
    this.rate,
    this.total,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.rate * value.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
    Image imageUrl,
    double total,
    int quantity,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          itemId: existingItem.itemId,
          itemName: existingItem.itemName,
          rate: existingItem.rate,
          imageUrl: existingItem.imageUrl,
          quantity: existingItem.quantity + 1,
          total: existingItem.total + existingItem.rate,
        ),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                itemId: DateTime.now().toString(),
                itemName: title,
                rate: price,
                quantity: quantity,
                imageUrl: imageUrl,
                total: total,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingItem) => CartItem(
                itemId: existingItem.itemId,
                itemName: existingItem.itemName,
                rate: existingItem.rate,
                imageUrl: existingItem.imageUrl,
                quantity: existingItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
