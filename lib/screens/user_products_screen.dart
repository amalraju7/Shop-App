import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class UserProductScreen extends StatelessWidget {

  static final routeName = '/user_products_screen';
  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context,listen: false).fetchAndSetProducts(true);
  }


  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);
    return Scaffold(appBar: AppBar(title: Text('Your Products'),
    actions: [IconButton(onPressed: (){
      Navigator.of(context).pushNamed(EditProductScreen.routeName);
    }, icon: Icon(Icons.add))],),
    drawer: AppDrawer(),
      body: FutureBuilder(future: refreshProducts(context)  , builder:(ctx,snapshot) => snapshot.connectionState == ConnectionState.waiting? Center(child: CircularProgressIndicator(),) : RefreshIndicator(

          onRefresh: (){
           return  refreshProducts(context);
          },
          child: Consumer<Products>(builder: (ctx, productData, _) =>  Padding
            (padding: EdgeInsets.all(8),child: ListView.builder(itemBuilder: (ctx,i)=> Column(
              children: [
                UserProductItem(id: productData.items[i].id,title: productData.items[i].title, imageUrl: productData.items[i].imageUrl),
                Divider(),
              ],
            ),itemCount: productData.items.length,),),
          ),
        ),
      ),
    );
  }
}