import 'package:flutter/material.dart';
import 'package:palit/providers/cart.dart';
import 'package:provider/provider.dart';

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Text('Total Amount',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Spacer(),
                  Consumer<Cart>(
                    builder: (BuildContext context, Cart cart, _) => Chip(
                      label: Text(
                        cart.totalAmount.toStringAsFixed(2),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        'ORDER NOW',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
