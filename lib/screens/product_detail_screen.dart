import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:trying/providers/products.dart';

// ignore: camel_case_types
class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product_detail';

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final ProductId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(ProductId);

    return Scaffold(
      appBar: AppBar(
        title: Text("ProductDetailScreen"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(loadedProduct.title),
                background: Hero(
                  tag: loadedProduct.id,
                  child: Image.network(
                    loadedProduct.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10,),
                Text(
                  '${loadedProduct.price}EGP',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,),
                  width: double.infinity,
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
