import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trying/providers/auth.dart';
import 'package:trying/providers/cart.dart';
import 'package:trying/providers/orders.dart';
import 'package:trying/providers/products.dart';
import 'package:trying/screens/auth_screen.dart';
import 'package:trying/screens/cart_screen.dart';
import 'package:trying/screens/edit_product_screen.dart';
import 'package:trying/screens/orders_screen.dart';
import 'package:trying/screens/product_detail_screen.dart';
import 'package:trying/screens/product_overview_screen.dart';
import 'package:trying/screens/user_products_screen.dart';
import './screens/splash_screen.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApps());
}

class MyApps extends StatefulWidget {
  const MyApps({Key key}) : super(key: key);

  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth,Products>(
          create:(_)=>Products() ,
          update: (ctx, authValue, previousProduct) => previousProduct
            ..getData(
                authValue.token,
                authValue.userId,
                previousProduct == null ? null : previousProduct.items
            ),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth,Orders>(
          create:(_)=>Orders() ,
          update: (ctx, authValue,  previousOrders) => previousOrders
            ..getData(
                authValue.token,
                authValue.userId,
                previousOrders == null ? null :  previousOrders.orders
            ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.pink,
              accentColor: Colors.orange,
              fontFamily: "Lato",
            ),
            home: auth.isAuth
                ? productOverView()
                : FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (ctx, AsyncSnapshot authSnapshot) =>
              authSnapshot.connectionState == ConnectionState.waiting
                  ? SplashScreen()
                  : AuthScreen(),
            ),
            routes: {
              ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
              CartScreen.routeName: (_) => CartScreen(),
              OrderProductScreen.routeName: (_) => OrderProductScreen(),
              UserProductScreen.routeName: (_) => UserProductScreen(),
              EditProductScreen.routeName: (_) => EditProductScreen(),
            }),
      ),
    );
  }
}

