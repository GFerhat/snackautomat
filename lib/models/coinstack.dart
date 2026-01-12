class Coinstack {
  Map<int, int> coins;

  Coinstack({required this.coins});

  /// Attempts to exchange amountInCent and applies the exchange to
  /// this Coinstack when successful.
  ///
  /// Returns a List with two maps [remainingCoins, usedCoins] if the
  /// exchange succeeds, otherwise returns null.
  List<Map<int, int>>? exchange(int amountInCent) {
    for (int startIndex = 0; startIndex < coins.length; startIndex++) {
      Map<int, int> result = {};
      int remaining = amountInCent;
      Map<int, int> availableCoins = Map.from(coins);

      if (_tryExchangeFrom(startIndex, availableCoins, result, remaining)) {
        result.forEach((coinValue, usedCount) {
          final current = coins[coinValue] ?? 0;
          coins[coinValue] = current - usedCount;
        });

        final remainingCoins = Map<int, int>.from(coins);
        final usedCoins = Map<int, int>.from(result);
        return [remainingCoins, usedCoins];
      }
    }
    return null;
  }

  bool _tryExchangeFrom(
    int startIndex,
    Map<int, int> availableCoins,
    Map<int, int> result,
    int remaining,
  ) {
    final availableCoinsList = availableCoins.entries.toList();
    for (int index = startIndex; index < availableCoinsList.length; index++) {
      final entry = availableCoinsList[index];
      int coinValue = entry.key;
      int coinAmount = entry.value;

      if (coinValue > remaining) {
        continue;
      }
      int maxPossible = remaining ~/ coinValue;
      int amountOfCoinNeeded = maxPossible < coinAmount
          ? maxPossible
          : coinAmount;

      if (amountOfCoinNeeded > 0) {
        result[coinValue] = (result[coinValue] ?? 0) + amountOfCoinNeeded;
        availableCoins[coinValue] = coinAmount - amountOfCoinNeeded;
        remaining -= coinValue * amountOfCoinNeeded;
      }

      if (remaining == 0) {
        return true;
      }
    }
    return false;
  }
}
