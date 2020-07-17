import 'package:flutter/material.dart';
import 'package:palit/providers/product.dart';

class ProductForm extends StatefulWidget {
  final String submitButtonText;
  final Function(Product product) submitAction;

  const ProductForm({
    Key key,
    this.submitButtonText = 'Save',
    @required this.submitAction,
  }) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  var imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void saveForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    final product = Product(
      id: null,
      title: titleController.text,
      description: descriptionController.text,
      imageUrl: imageUrlController.text,
      price: double.parse(priceController.text),
    );

    widget.submitAction(product);
  }

  @override
  Widget build(BuildContext context) {
    var priceFocusNode = FocusNode();
    var descriptionFocusNode = FocusNode();
    var imageUrlFocusNode = FocusNode();

    return Form(
      key: _formKey,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Title is required';
              }

              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
            controller: priceController,
            textInputAction: TextInputAction.next,
            focusNode: priceFocusNode,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(descriptionFocusNode),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Price is required';
              }

              final parsedValue = double.tryParse(value);
              if (parsedValue == null) {
                return 'Invalid price';
              }

              if (parsedValue < 0) {
                return 'Price should be greater than zero';
              }

              return null;
            },
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Image URL is required';
              }

              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            child: Text(
              widget.submitButtonText,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              saveForm();
            },
          )
        ],
      ),
    );
  }
}
