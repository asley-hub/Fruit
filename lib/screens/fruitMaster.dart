import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../classes/fruit.dart';
import 'fruitPreview.dart';
import 'fruitDetailsScreen.dart';
import 'cartScreen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/cartProvider.dart';

class FruitsMaster extends StatefulWidget {
  const FruitsMaster({
      super.key, 

      });

  @override
  State<FruitsMaster> createState() => _FruitsMasterState();
}

class _FruitsMasterState extends State<FruitsMaster> {
  late List<Fruit> _fruits;
  List<Fruit> _cart = [];
  late Future<List<Fruit>> lesFruitsFuture = getFruits();
  late List<String> saisons = ['Tous'];
  late String saisonSelect = saisons[0];

  Future<List<Fruit>> getFruits() async {
    List<Fruit> fruits = [];
    final response = await http.get(Uri.parse('https://fruits.shrp.dev/items/fruits?fields=*.*'));

   if (response.statusCode == 200) {
   try {
       final jsonResponse = jsonDecode(response.body)['data'];
      // final List<dynamic> fruitsList = jsonResponse['data'];
      // return fruitsList.map((fruitJson) => Fruit.fromJson(fruitJson)).toList();
      for(var fruit in jsonResponse){
        fruits.add(Fruit.fromJson(fruit));
      }

      for(var fruit in fruits){
        if(!saisons.contains(fruit.season)){
          saisons.add(fruit.season);
        }
      }
    } catch (e) {
      throw Exception('Failed to decode JSON');
    }
  } else {

    throw Exception('Failed to load album');
  }
  return fruits;
  }

  void fruitFiltre(value) {
    setState(() {
      lesFruitsFuture = getFruits();
      if (value == 'Tous') {
        saisonSelect = saisons[0];
      } else {
        saisonSelect = value;
        lesFruitsFuture.then((fruits) {
          for (var fruit in fruits) {
           fruits.where((fruit) => fruit.season.toLowerCase() == value.toString().toLowerCase()).toList();
          }
        });
      }
    });
  }

  void initState(){
    super.initState();
    getFruits();
    //_fruits = widget.fruits;
  }

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
         title: Consumer<CartProvider>(
              builder: (BuildContext context, CartProvider cart, widget) =>
                  Text("Total panier : ${cart.sum.toStringAsFixed(2)} €"),
            ),actions: <Widget>[
            IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
           DropdownButton<String>(
              value: saisonSelect,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String? value) {
                fruitFiltre(value);
              },
              items: saisons.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()),
          ],
        ),
        body: FutureBuilder<List<Fruit>>(
          future: getFruits(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final fruits = snapshot.data!;
               _fruits = fruits;
              return ListView.builder(
                itemCount: _fruits.length,
                itemBuilder: (context, index) {
                  final fruits = _fruits[index];
                  return FruitPreview(fruits: fruits);
                                      
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        
      ),
    );
    
  }
}