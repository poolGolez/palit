import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const API_KEY = 'AIzaSyBRwMrJYuKZlWmlnRzXNFAm4hLsF0O8hGI';

  Future<void> login(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$API_KEY';
    final requestBody = json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true
    });

    final response = await http.post(url, body: requestBody);
    print(json.decode(response.body));
  }
}
