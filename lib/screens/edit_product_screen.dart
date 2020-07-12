import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {

  static const ROUTE_NAME = '/manage/products/edit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
    );
  }
}
