import '../classes/fruit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'fruitDetailsScreen.dart';
import '../provider/cartProvider.dart';
import '../widget/QuantityBadge.dart';

class FruitPreview extends StatelessWidget{
   FruitPreview({
    Key? key,
    required this.fruits,
    }):super(key: key);

    final Fruit fruits;
    CartProvider cart = CartProvider();

    @override
    Widget build(BuildContext context){
      var cart = context.watch<CartProvider>();
      return ListTile(
        leading: Image.asset(fruits.image),
        tileColor: fruits.color,
        onTap: (){
            Navigator.push(context,
             MaterialPageRoute( builder: (context) => FruitDetailsScreen(fruit:fruits),
             ));
        },
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(fruits.name),
        Consumer<CartProvider>(
          builder: (context, cart, child) =>
              QuantityBadge(quantity: cart.nbFruitCart(fruits)),
        ),
      ]),
        trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => cart.addFruit(fruits),
      ),
      );
    }
}

