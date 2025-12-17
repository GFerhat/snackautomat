import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_snackautomat/test/testthecoin.dart';
import 'my_app.dart';

void main() {
  // runApp(const MyApp());
  final coinChanger = Coin({
    200: 1,
    100: 2,
    50: 1,
    20: 3,
    10: 0,
    5: 0,
    2: 0,
    1: 0,
  });

  log('60 Cent: ${coinChanger.exchange(60)}');
  log('30 Cent: ${coinChanger.exchange(30)}');
  log('55 Cent: ${coinChanger.exchange(55)}');
  log('7 Cent: ${coinChanger.exchange(7)}');
}
