import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.green),
          child: Text("placeholder for coinslit"),
        ), //coinslit
        Container(
          width: 200,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.yellow),
          child: Text("placeholder for billslit"),
        ), //billslit
        Container(
          width: 200,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.red),
          child: Text("placeholder for cardslit"),
        ), //card (erstmal nur visual)
        Container(
          width: 200,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.blue),
          child: Text("placeholder for cointray"),
        ), //coin tray
      ],
    );
  }
}
