import 'package:flutter/material.dart';
import 'origin.dart';
class Fruit {
  final int id;
  String name;
  Color color;
  double price;
  String image;
  int stock;
  Origin origin;
  String season;
  //static const String basePath = "assets/images/";

  Fruit({
    required this.id,
    required this.name,
    required this.color,
    required this.price,
    required this.image,
    required this.stock,
    required this.origin,
    required this.season
  });
  // }): image = basePath + name.toLowerCase() + ".png";
  
   factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      id: json['id'],
      name: json['name'],
      color: Color(int.parse(json['color'].replaceAll("#", "0xFF"))),
      price: json['price'].toDouble(),
      image:"assets/images/${json['image']}",
      stock: json['stock'],
      origin:Origin(
        id: json['origin']['id'],
        name: json['origin']['name'],
        location: Location(
          type: json['origin']['location']['type'],
          coordinates: json['origin']['location']['coordinates']
          ),
      ),
      season:json['season']
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'color': color,
        'image': image,
        'origin': origin,
        'season': season,
  };

  
}