import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Coinstack Exchange Logic', () {
    test('should prioritize larger denominations (Greedy Algorithm check)', () {
      final coinstack = Coinstack(
        coins: {200: 10, 100: 10, 50: 10, 20: 10, 10: 10, 5: 10, 2: 10, 1: 10},
      );

      final res = coinstack.exchange(160);

      expect(res, isNotNull);
      final remaining = res![0];
      final used = res[1];

      // Logical check: 160 should be 100 + 50 + 10
      expect(used, {100: 1, 50: 1, 10: 1});
      expect(
        coinstack.coins,
        remaining,
        reason: 'Internal state must update after exchange',
      );
    });

    test('should skip denominations with zero inventory', () {
      final coinstack = Coinstack(
        coins: {200: 10, 100: 10, 50: 10, 20: 10, 10: 0, 5: 0, 2: 0, 1: 0},
      );

      final res = coinstack.exchange(160);

      expect(res, isNotNull);
      final used = res![1];

      // Should use 100 + (3 x 20) because 50 + 10 is impossible
      expect(used, {100: 1, 20: 3});
    });

    test('should return null if exact change cannot be made', () {
      final coinstack = Coinstack(coins: {200: 1, 100: 0, 50: 0});

      // Asking for 150 when we only have a 200 coin
      final res = coinstack.exchange(150);

      expect(
        res,
        isNull,
        reason:
            'Should return null when no coin combination matches the target',
      );
    });

    test('should handle requesting exactly 0 change', () {
      final initialCoins = {200: 10, 100: 10};
      final coinstack = Coinstack(coins: Map.from(initialCoins));

      final res = coinstack.exchange(0);

      expect(res, isNotNull);
      expect(
        res![1],
        isEmpty,
        reason: 'Used coins should be empty for 0 exchange',
      );
      expect(res[0], initialCoins, reason: 'Inventory should remain unchanged');
    });

    test('should exhaust a denomination and move to the next', () {
      final coinstack = Coinstack(coins: {10: 2, 5: 10});

      // Requesting 25: should take both 10s and one 5
      final res = coinstack.exchange(25);

      expect(res![1], {10: 2, 5: 1});
      expect(coinstack.coins[10], 0);
      expect(coinstack.coins[5], 9);
    });
  });
}
