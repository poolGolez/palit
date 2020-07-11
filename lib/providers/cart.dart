import 'package:flutter/foundation.dart';

import './product.dart';

class CartItem {
  final Product product;
  int quantity = 1;

  CartItem(@required this.product, {this.quantity});
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  int get count {
    return _items.length;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (oldItem) => CartItem(
                oldItem.product,
                quantity: oldItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(product.id, () => CartItem(product));
    }

    notifyListeners();
  }
}
