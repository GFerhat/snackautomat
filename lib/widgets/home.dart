import 'package:flutter/material.dart';
import 'package:flutter_snackautomat/widgets/vending_machine/machine.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Machine()),
            //Admin button
          ],
        ),
      ),
    );
  }
}
