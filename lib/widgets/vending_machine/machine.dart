import 'package:flutter/material.dart';
import 'package:flutter_snackautomat/widgets/vending_machine/suspension_slot.dart';
import 'package:flutter_snackautomat/widgets/vending_machine/product_area/product_area.dart';
import 'package:flutter_snackautomat/widgets/vending_machine/sidebar.dart';

class Machine extends StatelessWidget {
  const Machine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light gray background
        border: Border.all(color: Colors.black, width: 2), // Black border
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: ProductArea(), flex: 3),
                VerticalDivider(width: 2, color: Colors.black),
                Expanded(child: Sidebar(), flex: 1),
              ],
            ),
          ),
          Divider(height: 2, color: Colors.black),
          SuspensionSlot(),
        ],
      ),
    );
  }
}
