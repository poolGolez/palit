import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  final _items = <Product>[
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get all {
    return [..._items];
  }

  List<Product> get favorites {
    return all.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return all.firstWhere((element) => element.id == id);
  }

  void update(String id, Product updatedProduct) {
    final index = _items.indexWhere((element) => element.id == id);
    _items[index] = updatedProduct;
    notifyListeners();
  }

  void addProduct(product) {
    final url = 'https://palit-cbb04.firebaseio.com/products.json';
    http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'favorite': product.isFavorite,
            }));

    _items.add(product);
    notifyListeners();
  }

  void delete(Product product) {
    final index = _items.indexWhere((element) => element.id == product.id);
    _items.removeAt(index);
    notifyListeners();
  }
}
