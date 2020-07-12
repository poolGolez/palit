import 'package:flutter/material.dart';
import '../widgets/the_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const ROUTE_NAME = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: TheDrawer(),
    );
  }
}
