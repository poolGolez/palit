import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {

static const ROUTE_NAME = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 6,
            child: Row(
              children: <Widget>[],
            ),
          )
        ],
      ),
    );
  }
}
