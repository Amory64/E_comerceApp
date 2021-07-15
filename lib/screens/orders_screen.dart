import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

// ignore: camel_case_types
class OrderProductScreen extends StatelessWidget {
  static const routeName= '/order_product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OrderProductScreen"),),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
        builder: (ctx, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else{
            if(snapshot.error !=null){
              return Center(
                child: Text('An error occurred!'),
              );
            }else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) =>
                    ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (BuildContext context, int index) =>
                          OrderItem(orderData.orders[index]),
                    ),
              );
            }
          }
        },
      ),
    );
  }
}