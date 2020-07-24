import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palit/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const ROUTE_NAME = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  void signIn(BuildContext context) {
    final email = _emailTextController.text;
    final password = _passwordTextController.text;
    Provider.of<Auth>(context, listen: false).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    _emailTextController.text = 'loop.edward@gmail.com';
    _passwordTextController.text = 'palit22';

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
                            controller: _emailTextController,
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            controller: _passwordTextController,
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
                            onPressed: () => signIn(context),
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
