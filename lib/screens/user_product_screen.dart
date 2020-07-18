import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../screens/add_product_screen.dart';
import '../widgets/the_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const ROUTE_NAME = '/manage/products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).all;

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddProductScreen.ROUTE_NAME);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: TheDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<Products>(context, listen: false).initialize();
        },
        child: ListView.builder(
          itemBuilder: (ctx, i) => UserProductItem(products[i]),
          itemCount: products.length,
        ),
      ),
    );
  }
}
