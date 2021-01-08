import 'package:flutter/material.dart';
import 'package:foody/models/cart.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var c = Provider.of<Cart>(context);
    var cart = c.items;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Shopping Cart', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(icon: Icon(Icons.clear,color: Colors.white,), onPressed: (){Provider.of<Cart>(context, listen: false).clear();})
        ],
      ),
      body:cart.length==0?Center(child: Text('There are no items in the cart yet',style: TextStyle(color: Colors.white),),) :ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white.withOpacity(0.8),
            child: ListTile(
              leading: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(cart.values.toList()[index].image),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              title: Text('Item Count: ${cart.values.toList()[index].quantity}'),
              subtitle:Text('Unit Price: ${cart.values.toList()[index].price}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete,color: Colors.black,),
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false).removeSingleItem(cart.values.toList()[index].id);
                    },
                  ),
                  IconButton(icon: Icon(Icons.clear,), onPressed: (){Provider.of<Cart>(context, listen: false).removeItem(cart.values.toList()[index].id);})
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}