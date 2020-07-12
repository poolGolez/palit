import 'package:flutter/material.dart';
import 'package:palit/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/user_product_screen.dart';
import './screens/edit_product_screen.dart';

void main() => runApp(PalitApplication());

class PalitApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigoAccent,
          accentColor: Colors.amberAccent,
          fontFamily: 'Lato',
        ),
        routes: {
          ProductOverviewScreen.ROUTE_NAME: (ctx) => ProductOverviewScreen(),
          CartScreen.ROUTE_NAME: (ctx) => CartScreen(),
          OrdersScreen.ROUTE_NAME: (ctx) => OrdersScreen(),
          UserProductScreen.ROUTE_NAME: (ctx) => UserProductScreen(),
          EditProductScreen.ROUTE_NAME: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
