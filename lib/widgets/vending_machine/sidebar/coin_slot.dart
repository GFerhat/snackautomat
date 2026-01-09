import 'package:flutter/material.dart';

class CoinSlot extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const CoinSlot({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
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
      child: InkWell(
        onTap: onTap,
        child: Center(child: Text(label)),
      ),
    );
  }
}
