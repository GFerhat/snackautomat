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
          child: InkWell(
            onTap: () {
              print("Coin inserted");
            },
            child: Text("Coinslot (clickable)"),
          ),
        ),
        Container(
          width: 200,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.yellow),
          child: InkWell(
            onTap: () {
              print("Bill inserted");
            },
            child: Text("Billslot (clickable)"),
          ),
        ),
        Container(
          width: 200,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.red),
          child: Text("Cardslot"),
        ), //card (erstmal nur visual)
        Container(
          width: 200,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.blue),
          child: Text("CoinTray"),
        ), //coin tray
      ],
    );
  }
}
