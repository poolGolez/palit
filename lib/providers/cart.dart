import 'package:flutter/foundation.dart';

import './product.dart';

class Cart with ChangeNotifier {
  Map<String, _CartItem> _items = {};

  int get count => _items.length;

  double get totalAmount => _items.values
      .fold(0.0, (amount, cartItem) => amount + cartItem.extendedPrice);

  List get items => [..._items.entries.toList()];

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (oldItem) => _CartItem(
                oldItem.product,
                quantity: oldItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(product.id, () => _CartItem(product));
    }

    notifyListeners();
  }

  void removeItem(Product product) {
    _items.remove(product.id);
    notifyListeners();
  }

  void removeSingleItem(Product product) {
    final cartItem = _items[product.id];
    if (cartItem.quantity > 1) {
      _items.update(
          product.id,
          (oldItem) =>
              _CartItem(oldItem.product, quantity: oldItem.quantity - 1));
    } else {
      _items.remove(product.id);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

class _CartItem {
  final Product product;
  int quantity;

  double get extendedPrice => product.price * quantity;

  _CartItem(this.product, {this.quantity = 1});
}
