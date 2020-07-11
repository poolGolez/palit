import 'package:flutter/foundation.dart';

import './order.dart';
import 'cart.dart';

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  void addOrder(Cart cart) {
    final order = Order(
      DateTime.now().toString(),
      cart.items.fold({}, (map, entry) {
        final cartItem = entry.value;
        map[cartItem.product] = cartItem.quantity;
        return map;
      }),
      DateTime.now(),
    );

    _orders.add(order);
  }
}
