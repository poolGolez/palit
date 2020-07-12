import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palit/providers/orders.dart';
import 'package:provider/provider.dart';

import '../widgets/the_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const ROUTE_NAME = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: TheDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              final order = orders.getAt(index);
              return Card(
                child: ListTile(
                  title: Text('\$${order.amount}'),
                  subtitle: Text(DateFormat('MMMM d, yyyy  hh:mm').format(order.dateTime)),
                ),
              );
            },
            itemCount: orders.length,
          ),
        ),
      ),
    );
  }
}
