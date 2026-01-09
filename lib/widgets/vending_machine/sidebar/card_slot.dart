import 'package:flutter/material.dart';

class CardSlot extends StatelessWidget {
  final String label;
  final Color color;

  const CardSlot({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(label)),
    );
  }
}
