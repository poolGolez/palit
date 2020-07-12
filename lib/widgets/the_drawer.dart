import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../screens/product_overview_screen.dart';

class TheDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.shop,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Shop',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ProductOverviewScreen.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.credit_card,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Orders',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.ROUTE_NAME);
              },
            ),
          ],
        ),
      ),
    );
  }
}
