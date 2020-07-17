import 'package:flutter/material.dart';
import 'package:palit/providers/product.dart';

class ProductForm extends StatelessWidget {
  final String submitButtonText;
  final Function(Product product) submitAction;

  const ProductForm({
    Key key,
    this.submitButtonText = 'Save',
    @required this.submitAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var priceController = TextEditingController();
    var descriptionController = TextEditingController();
    var imageUrlController = TextEditingController();

    var priceFocusNode = FocusNode();
    var descriptionFocusNode = FocusNode();
    var imageUrlFocusNode = FocusNode();

    return Form(
      child: ListView(
        padding: const EdgeInsets.all(15.0),
        children: <Widget>[
          TextFormField(
          autofocus: true,
            decoration: InputDecoration(labelText: 'Title'),
            textInputAction: TextInputAction.next,
            controller: titleController,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(priceFocusNode),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
            controller: priceController,
            textInputAction: TextInputAction.next,
            focusNode: priceFocusNode,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(descriptionFocusNode),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            controller: descriptionController,
            textInputAction: TextInputAction.next,
            focusNode: descriptionFocusNode,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(imageUrlFocusNode),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Image URL'),
            controller: imageUrlController,
            textInputAction: TextInputAction.done,
            focusNode: imageUrlFocusNode,
            onFieldSubmitted: (_) { },
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
            onPressed: () {
              final product = Product(
                id: null,
                title: titleController.text,
                description: descriptionController.text,
                imageUrl: imageUrlController.text,
                price: double.parse(priceController.text),
              );
              submitAction(product);
            },
          )
        ],
      ),
    );
  }
}
