class Coinstack {
  Map<int, int> coins;

  Coinstack({required this.coins});

  /// Attempts to exchange amountInCent and applies the exchange to
  /// this Coinstack when successful.
  ///
  /// Returns a List with two maps [remainingCoins, usedCoins] if the
  /// exchange succeeds, otherwise returns null.
  List<Map<int, int>>? exchange(int amountInCent) {
    final availableCoinsList = coins.entries.toList();
    for (
      int startIndex = 0;
      startIndex < availableCoinsList.length;
      startIndex++
    ) {
      Map<int, int> availableCoins = Map.from(coins);
      Map<int, int>? result = _tryExchangeFrom(
        startIndex,
        amountInCent,
        availableCoinsList,
        availableCoins,
      );

      if (result == null) continue;
      result.forEach((coinValue, usedCount) {
        final current = coins[coinValue] ?? 0;
        coins[coinValue] = current - usedCount;
      });

      final remainingCoins = Map<int, int>.from(coins);
      final usedCoins = Map<int, int>.from(result);
      return [remainingCoins, usedCoins];
    }
    return null;
  }

  Map<int, int>? _tryExchangeFrom(
    int startIndex,
    int amountInCent,
    List<MapEntry<int, int>> availableCoinsList,
    Map<int, int> availableCoins,
  ) {
    //Termination:
    if (amountInCent == 0) return {};
    if (startIndex >= availableCoinsList.length) return null;

    final entry = availableCoinsList[startIndex];
    int coinValue = entry.key;
    int coinAmount = entry.value;

    if (coinValue > amountInCent || coinAmount <= 0) {
      return _tryExchangeFrom(
        startIndex+1,
        amountInCent,
        availableCoinsList,
        availableCoins,
      );
    }

    int maxPossible = amountInCent ~/ coinValue;
    int maxToTry = maxPossible < coinAmount ? maxPossible : coinAmount;

    for (int tryAmount = maxToTry; tryAmount >= 0; tryAmount--) {
      int remaining = amountInCent - (coinValue * tryAmount);
      Map<int, int> newAvailableCoins = Map.from(availableCoins);
      newAvailableCoins[coinValue] = coinAmount - tryAmount;

      Map<int, int>? result = _tryExchangeFrom(
        startIndex+1,
        remaining,
        availableCoinsList,
        availableCoins,
      );
      if (result != null) {
        if (tryAmount > 0) {
          result[coinValue] = tryAmount;
        }
        return result;
      }
    }

    return null;
  }
}
