import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const ROUTE_NAME = '/manage/products/edit';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  MutableProduct _mutableProduct;
  Product _product;
  var _isInit = false;

  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImage);
    super.initState();
  }

  void _updateImage() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageFocusNode.removeListener(_updateImage);
    _imageFocusNode.dispose();

    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (!_form.currentState.validate()) {
      return;
    }

    _form.currentState.save();
    final product = _mutableProduct.toProduct();
    final products = Provider.of<Products>(context, listen: false);
    await products.update(product.id, product);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if(!_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      final products = Provider.of<Products>(context);
      _product = products.findById(productId);
      _mutableProduct = MutableProduct.from(_product);
      _imageUrlController.text = _product.imageUrl;
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              initialValue: _product.title,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Provide title of the product';
                }

                return null;
              },
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
              onSaved: (value) => _mutableProduct.title = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              initialValue: _product.price.toStringAsFixed(2),
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Provide the price of the product.';
                }

                if (double.tryParse(value) == null) {
                  return 'Invalid price value.';
                }

                if (double.parse(value) <= 0.0) {
                  return 'Price should be greater than zero.';
                }

                return null;
              },
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_descriptionFocusNode),
              onSaved: (value) => _mutableProduct.price = double.parse(value),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              initialValue: _product.description,
              focusNode: _descriptionFocusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Provide description of the product';
                }

                return null;
              },
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_imageFocusNode),
              onSaved: (value) => _mutableProduct.description = value,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter image URL')
                          : Image.network(_imageUrlController.text),
                    ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      focusNode: _imageFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Provide image URL of the product';
                        }

                        return null;
                      },
                      onSaved: (value) => _mutableProduct.imageUrl = value,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: _saveForm,
              child: Text(
                'SAVE',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class MutableProduct {
  final String id;
  String title;
  double price;
  String description;
  String imageUrl;

  MutableProduct({
    this.id,
    this.title,
    this.price,
    this.description,
    this.imageUrl,
  });

  Product toProduct() {
    return Product(
        id: id,
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl);
  }

  static MutableProduct from(Product product) {
    return MutableProduct(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );
  }

  @override
  String toString() {
    return "title: $title\n" +
        "price: $price\n" +
        "description: $description\n" +
        "imageUrl: $imageUrl";
  }
}
