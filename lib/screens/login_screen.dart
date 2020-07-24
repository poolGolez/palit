import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palit/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const ROUTE_NAME = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor
          ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: <Widget>[
            Spacer(
              flex: 4,
            ),
            Center(child: LayoutBuilder(builder: (ctx, constraints) {
              double width = min(constraints.maxWidth * 0.8, 350);
              double height = min(constraints.maxHeight * 0.4, 400);
              return Container(
                height: height,
                width: width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 25,
                    ),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 175,
                            child: Image.asset('assets/images/logo.jpeg'),
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Email address'),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(height: 10),
                          RaisedButton(
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Provider.of<Auth>(context, listen: false)
                                  .login('', '');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
            Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
