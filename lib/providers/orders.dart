import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './order.dart';
import './product.dart';
import 'cart.dart';

class Orders with ChangeNotifier {
  final String authToken;
  final String userId;
  List<Order> items;

  Orders(this.authToken, this.userId, this.items);

  int get length => items.length;

  Order getAt(index) => items[index];

  static const BASE_URL = 'https://palit-cbb04.firebaseio.com/orders';

  Future<void> initialize() async {
    final response = await http.get("$BASE_URL/$userId.json?auth=$authToken");
    Map<String, dynamic> ordersJson = json.decode(response.body);
    if(ordersJson == null) {
      items = [];
      return;
    }

    items = ordersJson.entries.map((entry) {
      final orderId = entry.key;
      final order = entry.value;

      var orderDetails = (order['items'] as List).map((item) {
        return OrderDetail(
          product: Product(
            id: item['product']['id'],
            title: item['product']['title'],
            description: item['product']['description'],
            imageUrl: null,
            price: null,
          ),
          price: item['price'],
          quantity: item['quantity'],
        );
      }).toList();

      return Order(
        orderId,
        orderDetails,
        order['amount'],
        DateTime.parse(order['timestamp']),
      );
    }).toList();
  }

  Future<void> addOrder(Cart cart) async {
    final order = Order(
      DateTime.now().toString(),
      cart.items.fold([], (items, entry) {
        final cartItem = entry.value;
        items.add(OrderDetail(
          product: cartItem.product,
          price: cartItem.product.price,
          quantity: cartItem.quantity,
        ));
        return items;
      }),
      cart.totalAmount,
      DateTime.now(),
    );

    var requestBody = _createRequestBody(order);
    var url = "$BASE_URL/$userId.json?auth=$authToken";
    await http.post(url, body: requestBody);

    items.add(order);
    notifyListeners();
  }

  String _createRequestBody(Order order) {
    return json.encode({
      'amount': order.amount,
      'timestamp': order.dateTime.toIso8601String(),
      'items': order.orderItems.map((orderItem) {
        return {
          'product': {
            'id': orderItem.product.id,
            'title': orderItem.product.title,
            'description': orderItem.product.description,
          },
          'price': orderItem.product.price,
          'quantity': orderItem.quantity,
        };
      }).toList()
    });
  }
}
