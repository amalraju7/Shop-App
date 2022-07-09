import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';


class UserProductItem extends StatelessWidget {
final String title;
final String id;
final String imageUrl;

UserProductItem({ @required this.id, @required this.title,@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
     
      child: ListTile(title: Text(title),leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);

          }, icon: Icon(Icons.edit),color: Theme.of(context).primaryColor,), IconButton(onPressed: (){

          Provider.of<Products>(context,listen: false).deleteItem(id);

          }, icon: Icon(Icons.delete,),color: Theme.of(context).primaryColor,),
    
        ],),
      ),
        
      ),
    );
  }
}