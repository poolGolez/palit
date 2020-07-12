import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/products.dart';
import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/product_item.dart';
import '../widgets/the_drawer.dart';

enum FilterOptions { Favorites, ShowAll }

class ProductOverviewScreen extends StatefulWidget {
  static const ROUTE_NAME = '/';

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  FilterOptions _filterOption = FilterOptions.ShowAll;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    final products = (_filterOption == FilterOptions.Favorites)
        ? productProvider.favorites
        : productProvider.all;

    return Scaffold(
      appBar: AppBar(
        title: Text('Palit Shop'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, Cart cart, Widget child) {
              return Badge(
                child: child,
                value: cart.count.toString(),
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.ROUTE_NAME);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                _filterOption = value;
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) {
              return <PopupMenuEntry>[
                CheckedPopupMenuItem(
                  checked: _filterOption == FilterOptions.Favorites,
                  child: Text('My Favorites'),
                  value: FilterOptions.Favorites,
                ),
                CheckedPopupMenuItem(
                  checked: _filterOption == FilterOptions.ShowAll,
                  child: Text('Show all'),
                  value: FilterOptions.ShowAll,
                ),
              ];
            },
          ),
        ],
      ),
      drawer: TheDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 2,
          ),
          itemCount: products.length,
          itemBuilder: (_, index) => ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(),
          ),
        ),
      ),
    );
  }
}
