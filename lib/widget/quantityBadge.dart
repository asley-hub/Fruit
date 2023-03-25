import 'package:flutter/material.dart';

class QuantityBadge extends StatelessWidget{
  QuantityBadge({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.red,
      ),
      child: Text(
        "$quantity",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}