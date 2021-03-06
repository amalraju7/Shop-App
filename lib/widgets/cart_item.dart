import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String product_id;
  final double price;
  final int quantity;
  final String title;
  const CartItem(
      {@required this.id,
      @required this.product_id,
      @required this.price,
      @required this.quantity,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20),
         margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
     
        return showDialog(context: context, builder: (ctx){ 
          return AlertDialog(title: Text("Are you sure?"),content: Text('Do you want to remove the item from the cart?'),actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop(false);
            }, child: Text('NO')), TextButton(onPressed: (){
              Navigator.of(context).pop(true);
            }, child: Text('Yes')), 
          ],);

        });
      
       },
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).deleteItem(product_id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(child: Text('\$${price}')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x '),
          ),
        ),
      ),
    );
  }
}
