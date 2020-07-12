import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final int quantity;

  CartItem(this.product, this.quantity);

  double get extendedPrice => product.price * quantity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 36,
        ),
      ),
      onDismissed: (direction) {
        final cart = Provider.of<Cart>(context, listen: false);
        cart.removeItem(product);
      },
      child: Card(
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
            "$quantity x",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Remove ${product.title}?"),
            content: Text("Are you sure you want to remove ${quantity} " +
                "piece(s) of ${product.title}(s) from your cart?"),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes, remove item'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
              RaisedButton(
                child: Text('No'),
                color: Theme.of(ctx).primaryColor,
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
