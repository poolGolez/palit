import './product.dart';

class Order {
  final String id;
  final Map<Product, int> orderItems;
  final double amount;
  final DateTime dateTime;

  Order(this.id, this.orderItems, this.amount, this.dateTime);
}
