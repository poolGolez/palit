import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = <Product>[];

  static const BASE_URL = 'https://palit-cbb04.firebaseio.com/products.json';

  List<Product> get all {
    return [..._items];
  }

  List<Product> get favorites {
    return all.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return all.firstWhere((element) => element.id == id);
  }

  Future<void> initialize() async {
    final response = await http.get(BASE_URL);
    Map<String, dynamic> productsJson = json.decode(response.body);

    _items = productsJson.entries.map((entry) {
      Map<String, dynamic> productData = entry.value;
      return Product(
          id: entry.key,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['image_url'],
          isFavorite: productData['is_favorite']);
    }).toList();
    notifyListeners();
  }

  void update(String id, Product updatedProduct) {
    final index = _items.indexWhere((element) => element.id == id);
    _items[index] = updatedProduct;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final url = 'https://palit-cbb04.firebaseio.com/products.json';
    var requestBody = json.encode({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image_url': product.imageUrl,
      'is_favorite': product.isFavorite,
    });

    try {
      final response = await http.post(url, body: requestBody);
      final savedProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      );
      _items.add(savedProduct);
      notifyListeners();
      return savedProduct;
    } catch (error) {
      print('caught error: ' + error.toString());
      throw error;
    }
  }

  void delete(Product product) {
    final index = _items.indexWhere((element) => element.id == product.id);
    _items.removeAt(index);
    notifyListeners();
  }
}
