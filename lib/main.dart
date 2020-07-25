import 'package:flutter/material.dart';
import 'package:palit/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/add_product_screen.dart';
import './screens/cart_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/login_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_product_screen.dart';

void main() => runApp(PalitApplication());

class PalitApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(null, []),
          update: (ctx, auth, previousProducts) {
            return Products(auth.token, previousProducts.all);
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigoAccent,
          accentColor: Colors.amberAccent,
          fontFamily: 'Lato',
        ),
        home: Consumer<Auth>(
          builder: (ctx, authProvider, _) {
            return authProvider.isAuthenticated
                ? ProductOverviewScreen()
                : LoginScreen();
          },
        ),
        routes: {
          CartScreen.ROUTE_NAME: (ctx) => CartScreen(),
          OrdersScreen.ROUTE_NAME: (ctx) => OrdersScreen(),
          UserProductScreen.ROUTE_NAME: (ctx) => UserProductScreen(),
          EditProductScreen.ROUTE_NAME: (ctx) => EditProductScreen(),
          AddProductScreen.ROUTE_NAME: (ctx) => AddProductScreen(),
        },
      ),
    );
  }
}
