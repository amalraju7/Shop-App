import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool showFavorites = false;
  bool _isInit=false;
  bool _isLoading = false;
  

  @override
  void didChangeDependencies() {
   if(_isInit==false){
     setState(() {
           _isLoading = true;
     });
 
     Provider.of<Products>(context).fetchAndSetProducts().then((value) { setState(() {
        _isLoading=false;
     });  } );
     _isInit =true;
   }

    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context);
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                setState(() {
                  if (value == FilterOptions.All) {
                    showFavorites = false;
                  } else {
                    showFavorites = true;
                  }
                });
              },
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  ),
                ];
              }),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
                child: child,
                value: cart.itemCount.toString()),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {Navigator.of(context).pushNamed(CartScreen.routeName);},
                ),
          ),
        ],
      ),drawer: AppDrawer(),
      body: _isLoading? Center(child: CircularProgressIndicator(),):ProductsGrid(showFavorites),
    );
  }
}
