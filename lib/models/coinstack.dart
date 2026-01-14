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
      int remaining = amountInCent;
      Map<int, int> availableCoins = Map.from(coins);
      Map<int, int>? result = _tryExchangeFrom(
        startIndex,
        availableCoins,
        remaining,
      );

      if (result != null) {
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

  Map<int, int>? _tryExchange(
    // int startIndex,
    Map<int, int> availableCoins,
    int remaining,
  ) {
    availableCoins = {2: 1, 1: 1};
    remaining = 1;

    final currentCoin = 2;
    final coinAmount = availableCoins.remove(currentCoin);
    final Map<int, int> result = {};

    {
      //
      // wir berechnen wieviele wir von was rausnehmen können und wie hoch der remaining danach noch ist;
      //
      if (remaining == 0) {
        return result;
      }

      final subResult = _tryExchange(availableCoins, remaining);
      if (subResult == null) {
        return null;
      }
    return result + subResult;
    }

  }
  //   Map<int, int>? _tryExchangeFrom(
  //     int startIndex,
  //     Map<int, int> availableCoins,
  //     int remaining,
  //   ) {
  //     final Map<int, int> result = {};
  //     final availableCoinsList = availableCoins.entries.toList();
  //     for (int index = startIndex; index < availableCoinsList.length; index++) {
  //       final entry = availableCoinsList[index];
  //       int coinValue = entry.key;
  //       int coinAmount = entry.value;

  //       if (coinValue > remaining) {
  //         continue;
  //       }
  //       int maxPossible = remaining ~/ coinValue;
  //       int amountOfCoinNeeded = maxPossible < coinAmount
  //           ? maxPossible
  //           : coinAmount;

  //       if (amountOfCoinNeeded > 0) {
  //         result[coinValue] = (result[coinValue] ?? 0) + amountOfCoinNeeded;
  //         availableCoins[coinValue] = coinAmount - amountOfCoinNeeded;
  //         remaining -= coinValue * amountOfCoinNeeded;
  //       }

  //       if (remaining == 0) {
  //         return result;
  //       }
  //     }
  //     return null;
  //   }
}
