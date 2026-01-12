import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_test/flutter_test.dart';
void main () {
  test('test coinstack',() {
    Coinstack coinstack = Coinstack(coins: {
    200:10,
    100:10,
    50:10,
    20:10,
    10:10,
    5:10,
    2:10,
    1:10    
    });

    coinstack.exchange(160);
  });
}