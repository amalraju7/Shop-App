
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class ProductsGrid extends StatelessWidget {

 bool showFavorites;
   ProductsGrid( this.showFavorites);

  @override
  Widget build(BuildContext context) {
   final productsData =   Provider.of<Products>(context);

   List<Product> products ;
   if(showFavorites){
     products = productsData.favoriteItems; 
   }else{
 products = productsData.items; 
   }
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value( value:products[i],
        child: ProductItem(
       
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}