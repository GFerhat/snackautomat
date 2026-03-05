class Coinstack {
  Map<int, int> coins;

  Coinstack({this.coins = const {}});

  /// Attempts to exchange amountInCent and applies the exchange to
  /// this Coinstack when successful.
  ///
  /// Returns a List with two maps [remainingCoins, usedCoins] if the
  /// exchange succeeds, otherwise returns null.
  ExchangeResult? tryExchange(int amountInCent) {
    final localCoins = {...coins};
    final availableCoinsList = localCoins.entries.toList();
    for (
      int startIndex = 0;
      startIndex < availableCoinsList.length;
      startIndex++
    ) {
      Map<int, int> availableCoins = Map.from(localCoins);
      Map<int, int>? result = _tryExchangeFrom(
        startIndex,
        amountInCent,
        availableCoinsList,
        availableCoins,
      );

      if (result == null) continue;
      result.forEach((coinValue, usedCount) {
        final current = localCoins[coinValue] ?? 0;
        localCoins[coinValue] = current - usedCount;
      });

      final remainingCoins = Map<int, int>.from(localCoins);
      final usedCoins = Map<int, int>.from(result);
      return ExchangeResult(
        remainingCoins: remainingCoins,
        usedCoins: usedCoins,
      );
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
        startIndex + 1,
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
        startIndex + 1,
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

class ExchangeResult {
  Map<int, int> usedCoins;
  Map<int, int> remainingCoins;

  ExchangeResult({this.usedCoins = const {}, this.remainingCoins = const {}});
}

extension CoinstackX on Coinstack {
  /// Calculates the total value of all coins in the stack in cents.
  int get totalValue {
    return coins.entries.fold(0, (sum, entry) => sum + (entry.key * entry.value));
  }
}