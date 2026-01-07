import 'package:flutter/material.dart';

class SuspensionSlot extends StatelessWidget {
  const SuspensionSlot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Text("placeholder for suspension slot"),
      decoration: BoxDecoration(color: Colors.deepOrangeAccent),
    );
  }
}
