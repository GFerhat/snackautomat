import 'package:flutter/material.dart';
import 'package:flutter_snackautomat/widgets/vending_machine/item_output.dart';
import 'package:flutter_snackautomat/widgets/vending_machine/product_area/product_area.dart';
import 'package:flutter_snackautomat/widgets/vending_machine/sidebar.dart';

class Machine extends StatelessWidget {
  const Machine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [ProductArea() /*Sidebar()*/]),
        // ItemOutput(),
      ],
    );
  }
}
