import 'package:flutter/material.dart';
import 'package:flutter_snackautomat/widgets/vending_machine/machine.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Machine(),
            //Admin button
          ],
        ),
      ),
    );
  }
}
