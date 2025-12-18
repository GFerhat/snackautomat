import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_snackautomat/test/testthecoin.dart';
import 'my_app.dart';

void main() {
  // runApp(const MyApp());
  final coinChanger = Coinstack({
    200: 100,
    100: 100,
    50: 100,
    20: 100,
    10: 100,
    5: 100,
    2: 100,
    1: 100,
  });

  log('60 Cent: ${coinChanger.exchange(60)}');
  log('30 Cent: ${coinChanger.exchange(30)}');
  log('55 Cent: ${coinChanger.exchange(55)}');
  log('7 Cent: ${coinChanger.exchange(7)}');
}
