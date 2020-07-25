import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palit/models/http_client_exception.dart';
import 'package:palit/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const ROUTE_NAME = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  var _passwordFocusNode = FocusNode();

  var _loggingIn = false;
  var _errorMessage;

  Future<void> signIn(BuildContext context) async {
    _errorMessage = null;
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _loggingIn = true;
    });
    final email = _emailTextController.text;
    final password = _passwordTextController.text;

    try {
      await Provider.of<Auth>(context, listen: false).login(email, password);
    } on HttpClientException catch (error) {
      if (error.message.contains('INVALID_PASSWORD')) {
        _errorMessage = 'Invalid email and/or password.';
      } else if (error.message.contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        _errorMessage = 'Too many invalid attempts. Try again later.';
      }
    } catch (error) {
      _errorMessage = 'Check network connectivity';
    } finally {
      setState(() {
        _loggingIn = false;
      });
    }
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
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 150,
                            child: Image.asset('assets/images/logo.jpeg'),
                          ),
                          SizedBox(height: 10),
                          if (_errorMessage != null)
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Theme.of(context).errorColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(
                                _errorMessage,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Email address'),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: _emailTextController,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter email address';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            controller: _passwordTextController,
                            focusNode: _passwordFocusNode,
                            onFieldSubmitted: (_) => signIn(context),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter passowrd';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          _loggingIn
                              ? CircularProgressIndicator()
                              : RaisedButton(
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
