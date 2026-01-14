import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test coinstack', () {
    Coinstack coinstack = Coinstack(
      coins: {200: 10, 100: 10, 50: 10, 20: 10, 10: 10, 5: 10, 2: 10, 1: 10},
    );

    final res = coinstack.exchange(160);

    expect(res, isNotNull);
    final remaining = res![0];
    final used = res[1];

    expect(remaining, {
      200: 10,
      100: 9,
      50: 9,
      20: 10,
      10: 9,
      5: 10,
      2: 10,
      1: 10,
    });

    expect(used, {100: 1, 50: 1, 10: 1});

    expect(coinstack.coins, remaining);
  });

  test('test coinstack modified', () {
    Coinstack coinstack = Coinstack(
      coins: {200: 10, 100: 10, 50: 10, 20: 10, 10: 0, 5: 0, 2: 0, 1: 0},
    );

    final res = coinstack.exchange(160);

    expect(res, isNotNull);
    final remaining = res![0];
    final used = res[1];

    expect(remaining, {
      200: 10,
      100: 9,
      50: 10,
      20: 7,
      10: 0,
      5: 0,
      2: 0,
      1: 0,
    });

    expect(used, {100: 1, 20: 3});

    expect(coinstack.coins, remaining);
  });
}
