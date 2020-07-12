import 'package:flutter/material.dart';

import '../widgets/the_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const ROUTE_NAME = '/manage/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
      ),
      drawer: TheDrawer(),
    );
  }
}
