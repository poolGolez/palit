import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  static const ROUTE_NAME = '/products/add';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
    );
  }
}
