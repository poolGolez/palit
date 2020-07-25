import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:palit/models/http_client_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String userId;
  DateTime _expirationDate;

  static const API_KEY = 'AIzaSyBRwMrJYuKZlWmlnRzXNFAm4hLsF0O8hGI';

  bool get isAuthenticated => _token != null && _expirationDate.isAfter(DateTime.now());
  String get token => _token;

  Future<void> login(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$API_KEY';
    final requestBody = json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true});

    final response = await http.post(url, body: requestBody);
    final responseBody = json.decode(response.body);

    if (responseBody['error'] != null) {
      throw HttpClientException(responseBody['error']['message']);
    }

    // print("TOKEN: " + responseBody['idToken']);
    // print("USER ID: " + responseBody['localId']);
    // print("EXPIRATION: " + responseBody['expiresIn']);

    _token = responseBody['idToken'];
    userId = responseBody['localId'];
    var duration = Duration(seconds: int.parse(responseBody['expiresIn']));
    _expirationDate = DateTime.now().add(duration);
    notifyListeners();
  }
}
