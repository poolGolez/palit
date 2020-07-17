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
              submitButton: RaisedButton(
                child: Text(
                  'Create new product',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
