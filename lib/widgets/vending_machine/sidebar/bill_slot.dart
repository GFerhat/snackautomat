import 'package:flutter/material.dart';

class BillSlot extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final String? imagePath;

  const BillSlot({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF1B1B1B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 6,
              offset: const Offset(2, 2),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
