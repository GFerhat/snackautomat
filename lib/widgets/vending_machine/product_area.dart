import 'package:flutter/material.dart';

class ProductArea extends StatelessWidget {
  const ProductArea({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 3);
  }
}
