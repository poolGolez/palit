import 'package:flutter/material.dart';
import 'package:palit/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/the_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const ROUTE_NAME = '/manage/products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
      ),
      drawer: TheDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => UserProductItem(products[i]),
        itemCount: products.length,
      ),
    );
  }
}
