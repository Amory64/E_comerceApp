import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trying/providers/products.dart';
import 'package:trying/screens/edit_product_screen.dart';


class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String avatar;

  const UserProductItem(
      this.id,
      this.title,
      this.avatar,
      );


  @override
  Widget build(BuildContext context) {
    final scaffold=Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatar),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: ()=> Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                    arguments: id
                ) ,
            ),
            IconButton(icon: Icon(Icons.delete), onPressed: () async{
              try{
                await Provider.of<Products>(context,listen: false).deleteProduct(id);
              }catch(e){
                scaffold.showSnackBar(
                  SnackBar(
                      content:Text(
                        'Deleting Field',
                        textAlign: TextAlign.center,
                )),
                );
              }
            },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
