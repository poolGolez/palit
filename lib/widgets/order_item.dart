import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('\$${order.amount}'),
        subtitle:
            Text(DateFormat('MMMM d, yyyy  hh:mm').format(order.dateTime)),
        trailing: IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: () {},
        ),
      ),
    );
  }
}
