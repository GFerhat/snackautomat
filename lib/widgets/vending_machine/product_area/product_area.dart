import 'package:flutter/material.dart';

class ProductArea extends StatelessWidget {
  const ProductArea({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: List.generate(
        9,
        (index) => Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Column(children: [Text('${index + 1}'), Text('Snack'),Text('Price')]),
        ),
      ),
    );
  }
}
