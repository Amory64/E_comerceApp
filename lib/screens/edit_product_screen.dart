import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trying/providers/product.dart';
import 'package:trying/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit_product';

  const EditProductScreen({Key key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _avatarController = TextEditingController();
  final _avatarFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    avatar: '',
  );
  var _initialValues = {
    "title": '',
    "description": '',
    "price": '',
    "avatar": '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  @override
  void initState() {
    super.initState();
    _avatarFocusNode.addListener(_updateAvatar);
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initialValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString(),
          "avatar": "",
        };
        _avatarController.text = _editedProduct.avatar;
      }
      _isInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _avatarFocusNode.removeListener(_updateAvatar);
    _priceFocusNode.dispose();
    _avatarController.dispose();
    _avatarFocusNode.dispose();
    _descriptionFocusNode.dispose();
  }

  void _updateAvatar() {
    if (_avatarFocusNode.hasFocus) {
      if ((!_avatarController.text.startsWith('http') &&
              !_avatarController.text.startsWith('https')) ||
          (!_avatarController.text.endsWith('.png') &&
              !_avatarController.text.endsWith('.jpg') &&
              !_avatarController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id == null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (e) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occurred!'),
                  content: Text('Something went wrong.'),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Text("Okay!")),
                  ],
                ));
      }

    }
    setState(() {
      _isLoading=false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initialValues['title'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          price: _editedProduct.price,
                          title: value,
                          description: _editedProduct.description,
                          avatar: _editedProduct.avatar,
                          isFavourite: _editedProduct.isFavourite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number grater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          price: double.parse(value),
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          avatar: _editedProduct.avatar,
                          isFavourite: _editedProduct.isFavourite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initialValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          price: _editedProduct.price,
                          title: _editedProduct.title,
                          description: value,
                          avatar: _editedProduct.avatar,
                          isFavourite: _editedProduct.isFavourite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _avatarController.text.isEmpty
                              ? Text("Enter URL")
                              : FittedBox(
                                  child: Image.network(
                                    _avatarController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                            child: TextFormField(
                              controller: _avatarController,
                              decoration: InputDecoration(labelText: 'Image URL'),
                              maxLines: 3,
                              keyboardType: TextInputType.url,
                              focusNode: _avatarFocusNode,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter an image URL.';
                                }
                                if (!value.startsWith("http") &&!value.startsWith("https") ) {
                                  return 'Please enter a valid URL';
                                }
                                if (!value.endsWith("png") &&!value.endsWith("jpg")&& !value.endsWith("jpeg")) {
                                  return 'Please enter a valid URL';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedProduct = Product(
                                  id: _editedProduct.id,
                                  price: _editedProduct.price,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  avatar: value,
                                  isFavourite: _editedProduct.isFavourite,
                                );
                              },
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
