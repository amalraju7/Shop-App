import 'package:flutter/material.dart';
class CartItem{
  final String id;
  final String title;
   int quantity;
  final double price;
  CartItem( {@required this.id, @required this.title, @required this.quantity, @required this.price});
}

class Cart with ChangeNotifier{
  Map<String,CartItem> _items ={ };

  int get itemCount{
    return _items.length;
    
  }

  double get totalAmount{
    var total = 0.0;
    _items.forEach((key, cartItem) { 
      
      total += cartItem.quantity * cartItem.price;
    });

    return total;
  }

  Map<String,CartItem> get items{
    return {..._items};
  }
  void addItem(String productId,double price,String title,){
    if(_items.containsKey(productId)){
        _items.update(productId, (existingCartItem) => CartItem(id: existingCartItem.id, title: existingCartItem.title, quantity: existingCartItem.quantity+1, price: existingCartItem.price));
    }
    else{
      _items.putIfAbsent(productId, () => CartItem(id: DateTime.now().toString(), title: title, quantity: 1, price: price));
    }
    notifyListeners();
  }

  void deleteItem(String id){
    _items.remove(id);
    notifyListeners();
  }

  void clearCart(){
    _items = {};
    notifyListeners();
  }

  void undoItem(String id){
    if(!_items.containsKey(id)){
      return;
    }
    

    if(_items[id].quantity >1){
      _items[id].quantity-=1;

    }
    else{
      _items.remove(id);
    }
    notifyListeners();
  }

}