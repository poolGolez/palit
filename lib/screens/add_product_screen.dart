import 'package:flutter/material.dart';
import 'package:palit/widgets/product_form.dart';

class AddProductScreen extends StatelessWidget {
  static const ROUTE_NAME = '/products/add';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ProductForm(
              submitButtonText: 'Create new product',
              submitAction: (product) {
                print("TITLE: " + product.title);
                print("DESCRIPTION: " + product.description);
                print("PRICE: " + product.price.toString());
                print("URL: " + product.imageUrl);
              },
            ),
          ),
        ],
      ),
    );
  }
}
