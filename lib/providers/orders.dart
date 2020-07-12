import 'package:flutter/foundation.dart';

import './order.dart';
import 'cart.dart';

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  int get length => _orders.length;

  Order getAt(index) => _orders[index];

  void addOrder(Cart cart) {
    final order = Order(
      DateTime.now().toString(),
      cart.items.fold({}, (map, entry) {
        final cartItem = entry.value;
        map[cartItem.product] = cartItem.quantity;
        return map;
      }),
      cart.totalAmount,
      DateTime.now(),
    );

    _orders.add(order);
    notifyListeners();
  }
}
