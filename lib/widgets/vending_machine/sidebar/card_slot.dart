import 'package:flutter/material.dart';

class CardSlot extends StatelessWidget {
  final String label;
  final Color color;
  final String? imagePath;

  const CardSlot({
    super.key,
    required this.label,
    required this.color,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          if (imagePath != null)
            Image.asset(imagePath!, height: 40),

          const SizedBox(height: 6),

          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
