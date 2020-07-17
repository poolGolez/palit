import 'package:flutter/material.dart';

class ProductForm extends StatelessWidget {

  final StatelessWidget submitButton;

  const ProductForm({this.submitButton});

  @override
  Widget build(BuildContext context) {
    return Form(
        // key: _form,
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              // initialValue: _product.title,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Provide title of the product';
                }

                return null;
              },
              // onFieldSubmitted: (_) =>
              //     FocusScope.of(context).requestFocus(_priceFocusNode),
              // onSaved: (value) => _mutableProduct.title = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              // initialValue: _product.price.toStringAsFixed(2),
              keyboardType: TextInputType.number,
              // focusNode: _priceFocusNode,
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
              // onFieldSubmitted: (_) =>
              //     FocusScope.of(context).requestFocus(_descriptionFocusNode),
              // onSaved: (value) => _mutableProduct.price = double.parse(value),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              // initialValue: _product.description,
              // focusNode: _descriptionFocusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Provide description of the product';
                }

                return null;
              },
              // onFieldSubmitted: (_) =>
              //     FocusScope.of(context).requestFocus(_imageFocusNode),
              // onSaved: (value) => _mutableProduct.description = value,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  // Container(
                  //   height: 100,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black),
                  //   ),
                  //   child: FittedBox(
                  //     fit: BoxFit.cover,
                  //     child: _imageUrlController.text.isEmpty
                  //         ? Text('Enter image URL')
                  //         : Image.network(_imageUrlController.text),
                  //   ),
                  //   alignment: Alignment.center,
                  // ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      // controller: _imageUrlController,
                      // focusNode: _imageFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Provide image URL of the product';
                        }

                        return null;
                      },
                      // onSaved: (value) => _mutableProduct.imageUrl = value,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            submitButton
          ],
        ),
      );
  }
}
