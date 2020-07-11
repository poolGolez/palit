import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_item.dart';

enum FilterOptions { Favorites, ShowAll }

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    final products = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Palit Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              print("Selected $value");
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
