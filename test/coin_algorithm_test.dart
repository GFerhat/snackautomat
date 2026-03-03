import 'package:flutter/foundation.dart';
import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Coinstack Exchange Logic', () {
    test('should prioritize larger denominations (Greedy Algorithm check)', () {
      final coinstack = Coinstack(
        coins: {200: 10, 100: 10, 50: 10, 20: 10, 10: 10, 5: 10, 2: 10, 1: 10},
      );
      final beforeCoins = {...coinstack.coins};
      final res = coinstack.tryExchange(160);
      
      final afterCoins = {...coinstack.coins};

      expect(res, isNotNull);
      final remaining = res!.remainingCoins;
      final used = res.usedCoins;

      // Logical check: 160 should be 100 + 50 + 10
      expect(used, {100: 1, 50: 1, 10: 1});
      expect(
        mapEquals(beforeCoins, afterCoins),
        true,
        reason: 'Internal state must update after exchange',
      );
    });

    test('should skip denominations with zero inventory', () {
      final coinstack = Coinstack(
        coins: {200: 10, 100: 10, 50: 10, 20: 10, 10: 0, 5: 0, 2: 0, 1: 0},
      );

      final res = coinstack.tryExchange(160);

      expect(res, isNotNull);
      final used = res!.usedCoins;

      // Should use 100 + (3 x 20) because 50 + 10 is impossible
      expect(used, {100: 1, 20: 3});
    });

    test('should return null if exact change cannot be made', () {
      final coinstack = Coinstack(coins: {200: 1, 100: 0, 50: 0});

      // Asking for 150 when we only have a 200 coin
      final res = coinstack.tryExchange(150);

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

      final res = coinstack.tryExchange(0);

      expect(res, isNotNull);
      expect(
        res!.usedCoins,
        isEmpty,
        reason: 'Used coins should be empty for 0 exchange',
      );
      expect(
        res.remainingCoins,
        initialCoins,
        reason: 'Inventory should remain unchanged',
      );
    });

    test('should exhaust a denomination and move to the next', () {
      final coinstack = Coinstack(coins: {10: 2, 5: 10});

      // Requesting 25: should take both 10s and one 5
      final res = coinstack.tryExchange(25);

      expect(res!.usedCoins, {10: 2, 5: 1});
      expect(res.remainingCoins[10], 0);
      expect(res.remainingCoins[5], 9);
    });
  });
}
