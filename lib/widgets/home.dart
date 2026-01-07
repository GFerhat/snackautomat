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
            SizedBox(height: 50),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 90),
                child: Machine(),
              ),
            ),
            //Admin button
          ],
        ),
      ),
    );
  }
}
