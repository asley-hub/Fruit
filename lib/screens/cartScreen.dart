import '../classes/fruit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import '../provider/cartProvider.dart';

class CartScreen extends StatelessWidget{
  CartScreen({super.key});

  CartProvider cart = CartProvider();
  
  @override
  Widget build(BuildContext context){
     var cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Montant : ${cart.sum.toStringAsFixed(2)} €'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: 
              cart.clearCart,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (BuildContext context, int index){
          final fruit = cart.items[index];
          return ListTile(
            leading: Image.asset(fruit.image, width: 50, height: 50),
            title: Text(fruit.name),
            subtitle: Text('${fruit.price.toStringAsFixed(2)} €'),
            trailing: const Icon(Icons.delete),
            onTap:(){
              cart.removeFruit(fruit);
            },
          );
      },
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}