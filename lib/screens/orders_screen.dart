import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart';
import '../widgets/the_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const ROUTE_NAME = '/orders';

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<Orders>(context);
    // orders.initialize();

    return Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
        ),
        drawer: TheDrawer(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context).initialize(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (dataSnapshot.error != null) {
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "An error occured",
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text("It's not you. It's me."),
                  ],
                ),
              );
            }

            return Consumer<Orders>(builder: (ctx, orders, _) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) =>
                          OrderItem(orders.getAt(index)),
                      itemCount: orders.length,
                    ),
                  ),
                ],
              );
            });
          },
        ));
  }
}
