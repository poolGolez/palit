import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/product_provider.dart';
import './screens/product_overview_screen.dart';

void main() => runApp(PalitApplication());

class PalitApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext _) => ProductProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigoAccent,
          accentColor: Colors.amberAccent,
          fontFamily: 'Lato',
        ),
        home: new ProductOverviewScreen(),
      ),
    );
  }
}
