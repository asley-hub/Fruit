import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'classes/fruit.dart';
import 'screens/fruitPreview.dart';
import 'screens/fruitDetailsScreen.dart';
import 'screens/cartScreen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'provider/cartProvider.dart';
import 'screens/fruitMaster.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CartProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FruitsMaster(
        //title: 'Flutter Demo Home Page',
       // fruits: fruits,
        ),
    );
  }
}





