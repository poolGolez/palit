import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/cart.dart';
import './providers/products.dart';
import './screens/cart_screen.dart';
import './screens/product_overview_screen.dart';

void main() => runApp(PalitApplication());

class PalitApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigoAccent,
          accentColor: Colors.amberAccent,
          fontFamily: 'Lato',
        ),
        home: new ProductOverviewScreen(),
        routes: {
          CartScreen.ROUTE_NAME: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
