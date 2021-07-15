import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: product.id),
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.avatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) =>
                IconButton(
                  icon: Icon(
                      product.isFavourite ? Icons.favorite : Icons
                          .favorite_border
                  ),
                  color: Theme
                      .of(context)
                      .accentColor,
                  onPressed: () {
                    product.toggleFavouriteStatus(
                        authData.token, authData.userId);
                  },
                ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("added to Cart!"),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(label: "UNDO!", onPressed: () {
                    cart.removeSingleItem(product.id);
                  },),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}