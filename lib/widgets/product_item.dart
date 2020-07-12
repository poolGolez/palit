import 'package:flutter/material.dart';
import 'package:palit/providers/cart.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => product.toggleFavorite(),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.75),
          trailing: Consumer<Cart>(
            builder: (_, Cart cart, __) => IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                cart.addItem(product);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added item to cart'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () => cart.removeSingleItem(product),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
