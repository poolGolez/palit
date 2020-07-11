import 'package:flutter/material.dart';

import '../providers/product.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final int quantity;

  CartItem(this.product, this.quantity);

  double get extendedPrice => product.price * quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
              child: Text(
                product.price.toStringAsFixed(2),
              ),
            ),
          ),
        ),
        title: Text(product.title),
        subtitle: Text("Extended: PHP ${extendedPrice.toStringAsFixed(2)}"),
        trailing: Text(
          "${quantity} x",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
