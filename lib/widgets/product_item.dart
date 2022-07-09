import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
       final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(product.isFavorite ? Icons.star: Icons.star_border_outlined),
            color: Theme.of(context).accentColor,
            onPressed:()async{
              try{
            await product.toggleFavoriteStatus();
              }catch(error){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Adding favorite failed!') ));
              }
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {cart.addItem(product.id, product.price, product.title);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added Item To Cart"),duration: Duration(seconds: 2),action: SnackBarAction(label: 'UNDO',onPressed: (){
              cart.undoItem(product.id);
            },),));
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
