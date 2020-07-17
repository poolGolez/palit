import 'package:flutter/material.dart';

class ProductForm extends StatelessWidget {
  final String submitButtonText;

  const ProductForm({
    Key key,
    this.submitButtonText = 'Save',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _priceFocusNode = FocusNode();
    var _descriptionFocusNode = FocusNode();
    var _imageUrlFocusNode = FocusNode();

    return Form(
      child: ListView(
        padding: const EdgeInsets.all(15.0),
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Title'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_priceFocusNode),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            focusNode: _priceFocusNode,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_descriptionFocusNode),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            textInputAction: TextInputAction.next,
            focusNode: _descriptionFocusNode,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_imageUrlFocusNode),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Image URL'),
            textInputAction: TextInputAction.done,
            focusNode: _imageUrlFocusNode,
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            child: Text(
              submitButtonText,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
