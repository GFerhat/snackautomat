import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_snackautomat/models/product.dart';
import 'package:flutter_snackautomat/provider/app_state.dart';

class AppStateNotifier extends Notifier<AppState> {
  @override
  AppState build() => AppState(
    coinsInInput: Coinstack(),
    coinsInMachine: Coinstack(
      coins: {200: 50, 100: 50, 50: 50, 20: 50, 10: 50, 5: 50, 2: 50, 1: 50},
    ),
    coinsInReturn: Coinstack(),
    products: [
      Product(id: '1', name: 'Cola', count: 5, price: 100),
      Product(id: '2', name: 'Fanta', count: 5, price: 100),
      Product(id: '3', name: 'Sprite', count: 5, price: 100),
      Product(id: '4', name: 'Snickers', count: 5, price: 200),
      Product(id: '5', name: 'Mars', count: 5, price: 200),
      Product(id: '6', name: 'Twix', count: 5, price: 170),
      Product(id: '7', name: 'Kinderriegel', count: 5, price: 90),
    ],
  );

  /// Resets the current input field to zero.
  void clearInput() {
    state = state.copyWith(
      coinsInInput: () => Coinstack(),
    );
  }

  void clearCointray() {
    state = state.copyWith(
      coinsInReturn: () => Coinstack(),
    );
  }

  void inputCoin(int value) {
    final newMap = Map<int, int>.from(state.coinsInInput.coins);
    newMap[value] = (newMap[value] ?? 0) + 1;
    state = state.copyWith(coinsInInput: () => Coinstack(coins: newMap));
  }

  /// Transfers input to machine stash.
  void confirmInput() {
    final machineMap = Map<int, int>.from(state.coinsInMachine.coins);
    final inputMap = state.coinsInInput.coins;

    for (var entry in inputMap.entries) {
      machineMap[entry.key] = (machineMap[entry.key] ?? 0) + entry.value;
    }

    state = state.copyWith(
      coinsInMachine: () => Coinstack(coins: machineMap),
      // We keep coinsInInput as the "Credit" the user has.
    );
  }

  /// used to either exchange after a purchase or when user returns his coins.
  void returnCoins() {
    final amountToReturn = state.coinsInInput.totalValue;
    if (amountToReturn == 0) return;

    final result = state.coinsInMachine.tryExchange(amountToReturn);

    if (result != null) {
      final currentReturnMap = Map<int, int>.from(state.coinsInReturn.coins);

      for (var entry in result.usedCoins.entries) {
        currentReturnMap[entry.key] =
            (currentReturnMap[entry.key] ?? 0) + entry.value;
      }

      state = state.copyWith(
        coinsInMachine: () => Coinstack(coins: result.remainingCoins),
        coinsInReturn: () => Coinstack(coins: currentReturnMap),
        coinsInInput: () => Coinstack(),
      );
    }
  }
}
