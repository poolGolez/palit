import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:palit/models/http_client_exception.dart';

class Auth with ChangeNotifier {
  static const API_KEY = 'AIzaSyBRwMrJYuKZlWmlnRzXNFAm4hLsF0O8hGI';

  Future<void> login(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$API_KEY';
    final requestBody = json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true});
    print(requestBody);

    final response = await http.post(url, body: requestBody);
    final responseBody = json.decode(response.body);
    print(responseBody);

    if (responseBody['error'] != null) {
      throw HttpClientException(responseBody['error']['message']);
    }
  }
}
