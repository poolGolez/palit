import 'package:flutter/material.dart';
import 'package:palit/screens/product_overview_screen.dart';

void main() => runApp(PalitApplication());

class PalitApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigoAccent,
        accentColor: Colors.amberAccent,
        fontFamily: 'Lato',
      ),
      home: new ProductOverviewScreen(),
    );
  }
}
