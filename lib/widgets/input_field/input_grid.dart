import 'package:flutter/material.dart';

class InputGrid extends StatelessWidget {
  const InputGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 5,);
  }
}