import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded;

  @override
  void initState() {
    _expanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(DateFormat('MMMM d, yyyy  hh:mm')
                .format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: (widget.order.orderItems.length * 30.0) + 10,
              color: Colors.grey[300],
              child: ListView(
                children: widget.order.orderItems.map((OrderDetail orderItem) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(orderItem.product.title),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${orderItem.quantity}x",
                            textAlign: TextAlign.end,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            orderItem.price.toStringAsFixed(2),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
