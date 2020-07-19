import 'package:flutter/foundation.dart';

import './product.dart';

class Order {
  final String id;
  List<OrderDetail> orderItems;
  final double amount;
  final DateTime dateTime;

  Order(this.id, this.orderItems, this.amount, this.dateTime);
}

class OrderDetail {
  final Product product;
  final double price;
  final int quantity;

  OrderDetail({
    @required this.product,
    @required this.price,
    @required this.quantity,
  });
}
