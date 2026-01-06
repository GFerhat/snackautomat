import 'package:flutter/material.dart';
import 'package:flutter_snackautomat/widgets/input_field/display_field.dart';
import 'package:flutter_snackautomat/widgets/input_field/input_grid.dart';

class Inputfield extends StatelessWidget {
  const Inputfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [DisplayField(), InputGrid()]));
  }
}
