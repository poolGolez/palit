import 'package:flutter/material.dart';

import '../providers/product.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Colors.yellow[700],
        child: Icon(Icons.edit, color: Colors.white, size: 32),
        padding: const EdgeInsets.only(left: 15.0),
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: Container(color: Colors.red),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.startToEnd) {
          Navigator.of(context).pushNamed(EditProductScreen.ROUTE_NAME, arguments: product.id);
          return Future.value(false);
        }
        return Future.value(true);
      },
      onDismissed: (_) {
        //.. do delete here!
        print('delete');
      },
      child: Card(
        elevation: 6,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.imageUrl),
          ),
          title: Text(product.title),
        ),
      ),
    );
  }
}
