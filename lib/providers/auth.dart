import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> login(String email, String password) async {
    final apiKey = 'AIzaSyBRwMrJYuKZlWmlnRzXNFAm4hLsF0O8hGI';
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey';
    final requestBody = json.encode({
      'email':  'loop.edward@gmail.com',
      'password': 'palit22',
      'returnSecureToken': true
    });

    final response = await http.post(url, body: requestBody);
    print(json.decode(response.body));
  }
}
