import 'package:fruit/screens/cartScreen.dart';
import '../classes/fruit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../provider/cartProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widget/QuantityBadge.dart';

class FruitDetailsScreen extends StatelessWidget {
  
  FruitDetailsScreen(
    {Key? key, 
    required this.fruit}) : super(key: key);

    final Fruit fruit;
    final CartScreen cart = CartScreen();

  @override
  Widget build(BuildContext context) {
     var cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(fruit.name),
      ),
      body: Center(
        child: Column(
           children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(fruit.image, height: 80, width: 80)),
            Padding(
                padding: const EdgeInsets.all(3), child: Text("Origin: ${fruit.origin.name}")),
            Padding(
                padding: const EdgeInsets.all(3),
                child: Text("Saison: ${fruit.season}")),
            Padding(
                padding: const EdgeInsets.all(3), child: Text("Stock: ${fruit.stock}")),
             Padding(
                padding: const EdgeInsets.all(3), child: Text("Tarif a l'unite: ${fruit.price}€")),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      Text("Quantité : "),
                      Consumer<CartProvider>(
                        builder: (context, cart, child) => QuantityBadge(
                            quantity: cart.nbFruitCart(fruit)),
                      ),
                    ]),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                  onPressed: () {
                    cart.addFruit(fruit);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${fruit.name} a été ajouté au panier."),
                    backgroundColor: Colors.blue,),);
                  },
                  child: Icon(Icons.shopping_cart),),
            ),
            Expanded(
                child: FlutterMap(
              options: MapOptions(
                center: LatLng(fruit.origin.location.coordinates[1],
                    fruit.origin.location.coordinates[0]),
                zoom: 5.5,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                  maxZoom: 20,
                  subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 50.0,
                      height: 50.0,
                      point: LatLng(fruit.origin.location.coordinates[1],
                          fruit.origin.location.coordinates[0]),
                      builder: (ctx) => const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ],
            )
            )
          ],
        ),
      ),
    );
  }
}