import 'package:flutter/material.dart';

import '../providers/product.dart';

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
  final _mutableProduct = MutableProduct();

  final _imageUrlController = TextEditingController(
      text: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg');

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

  void _saveForm() {
    _form.currentState.save();
    print(_mutableProduct);
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
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
              onSaved: (value) => _mutableProduct.title = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_descriptionFocusNode),
              onSaved: (value) => _mutableProduct.price = double.parse(value),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
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
  String title;
  double price;
  String description;
  String imageUrl;

  MutableProduct({
    this.title,
    this.price,
    this.description,
    this.imageUrl,
  });

  static MutableProduct from(Product product) {
    return MutableProduct(
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
