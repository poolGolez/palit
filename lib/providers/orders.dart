import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './order.dart';
import 'cart.dart';

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  int get length => _orders.length;

  Order getAt(index) => _orders[index];

  static const BASE_URL = 'https://palit-cbb04.firebaseio.com/orders';

  Future<void> addOrder(Cart cart) async {
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

    var requestBody = _createRequestBody(order);
    await http.post("$BASE_URL.json", body: requestBody);

    _orders.add(order);
    notifyListeners();
  }

  String _createRequestBody(Order order) {
    return json.encode({
      'amount': order.amount,
      'timestamp': order.dateTime.toIso8601String(),
      'items': order.orderItems.entries.map((e) {
        return {
          'product_id': e.key.id,
          'price': e.key.price,
          'quantity': e.value,
        };
      }).toList()
    });
  }
}
