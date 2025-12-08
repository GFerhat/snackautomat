import 'package:flutter/material.dart';
import 'package:flutter_snackautomat/widgets/input_field/inputfield.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(), //münz
        Container(), //schein
        Container(), //card (erstmal nur admin)
        Inputfield(),
        Container(), //geldAusgabeFach
      ],
    );
  }
}
