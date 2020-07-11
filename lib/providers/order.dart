import './product.dart';

class Order {
  final String id;
  final Map<Product, int> orderItems;
  final DateTime dateTime;

  Order(this.id, this.orderItems, this.dateTime);
}
