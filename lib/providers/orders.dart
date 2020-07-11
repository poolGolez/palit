import './order.dart';
import 'cart.dart';

class Orders {
  final List<Order> _orders = [];

  void addOrder(Cart cart) {
    final order = Order(
      DateTime.now().toString(),
      cart.items.fold({}, (map, cartItem) {
        map.putIfAbsent(cartItem.product, cartItem.quantity);
        return map;
      }),
      DateTime.now(),
    );

    _orders.add(order);
  }
}
