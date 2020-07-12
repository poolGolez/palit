import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const ROUTE_NAME = '/manage/products/edit';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_descriptionFocusNode),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_imageFocusNode),
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
                    child: false
                        ? Text('Enter image URL')
                        : FittedBox(
                        fit: BoxFit.cover,
                          child: Image.network('https://cf.shopee.ph/file/de7f04df0ae25cb4a9b0903670e15ceb'),
                        ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      focusNode: _imageFocusNode,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
