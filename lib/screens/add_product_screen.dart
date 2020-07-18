import 'package:flutter/material.dart';
import 'package:palit/providers/products.dart';
import 'package:palit/widgets/product_form.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const ROUTE_NAME = '/products/add';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Saving...')
                ],
              ),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: ProductForm(
                    submitButtonText: 'Create new product',
                    submitAction: (product) {
                      setState(() {
                        _isLoading = true;
                      });
                      final products =
                          Provider.of<Products>(context, listen: false);
                      return products.addProduct(product).then((_) {
                        Navigator.of(context).pop();
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
