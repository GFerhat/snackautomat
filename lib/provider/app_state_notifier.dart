import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_snackautomat/models/product.dart';
import 'package:flutter_snackautomat/provider/app_state.dart';

class AppStateNotifier extends Notifier<AppState> {
  @override
  AppState build() => AppState(
    coinsInInput: Coinstack(),
    // Initial coins inside the machine
    coinsInMachine: Coinstack(
      coins: {200: 50, 100: 50, 50: 50, 20: 50, 10: 50, 5: 50, 2: 50, 1: 50},
    ),
    coinsInReturn: Coinstack(),
    products: [
      Product(id: '1', name: 'Cola', count: 5, price: 100),
      Product(id: '2', name: 'Fanta', count: 5, price: 100),
      Product(id: '3', name: 'Sprite', count: 1, price: 100),
      Product(id: '4', name: 'Snickers', count: 5, price: 200),
      Product(id: '5', name: 'Mars', count: 5, price: 200),
      Product(id: '6', name: 'Twix', count: 5, price: 170),
      Product(id: '7', name: 'Kinderriegel', count: 1, price: 90),
      Product(id: '8', name: 'Rittersport', count: 5, price: 190),
      Product(id: '9', name: 'Rittersport', count: 5, price: 190),
    ],
  );

  /// Resets the user's digital credit to zero.
  void clearInput() {
    state = state.copyWith(
      coinsInInput: () => Coinstack(),
    );
  }

  /// Empties the physical coin tray where change is kept.
  void clearCointray() {
    state = state.copyWith(
      coinsInReturn: () => Coinstack(),
    );
  }

  /// Adds one coin to the user's current input.
  void inputCoin(int value) {
    final newMap = Map<int, int>.from(state.coinsInInput.coins);
    newMap[value] = (newMap[value] ?? 0) + 1;
    state = state.copyWith(coinsInInput: () => Coinstack(coins: newMap));
  }

  /// Moves all coins from the input area into the machine's stash.
  void confirmInput() {
    final machineMap = Map<int, int>.from(state.coinsInMachine.coins);
    final inputMap = state.coinsInInput.coins;

    for (var entry in inputMap.entries) {
      machineMap[entry.key] = (machineMap[entry.key] ?? 0) + entry.value;
    }

    state = state.copyWith(
      coinsInMachine: () => Coinstack(coins: machineMap),
    );
  }

  /// Combines two coin maps so coins add up correctly.
  Map<int, int> _mergeCoinMaps(Map<int, int> base, Map<int, int> additions) {
    final newMap = Map<int, int>.from(base);
    additions.forEach((value, count) {
      newMap[value] = (newMap[value] ?? 0) + count;
    });
    return newMap;
  }

  /// Returns the user's money by taking coins out of the machine stash.
  void returnCoins() {
    final amountToReturn = state.coinsInInput.totalValue;
    if (amountToReturn == 0) return;

    final result = state.coinsInMachine.tryExchange(amountToReturn);

    if (result != null) {
      state = state.copyWith(
        coinsInMachine: () => Coinstack(coins: result.remainingCoins),
        // Add the returned coins to the current tray content
        coinsInReturn: () => Coinstack(
          coins: _mergeCoinMaps(state.coinsInReturn.coins, result.usedCoins),
        ),
        coinsInInput: () => Coinstack(),
      );
    }
  }

  /// Processes a purchase, updates stock, and gives change.
  void purchaseProduct(Product product) {
    final userCredit = state.coinsInInput.totalValue;

    // Check if the user has enough money
    if (userCredit < product.price) {
      print("Not enough money!");
      return;
    }

    // Calculate change amount
    int changeToReturn = userCredit - product.price;

    // Check if machine has the right coins for change
    final result = state.coinsInMachine.tryExchange(changeToReturn);

    if (result != null) {
      state = state.copyWith(
        // Reduce product stock by 1
        products: () => state.products.map((p) {
          return p.id == product.id ? p.copyWith(count: p.count - 1) : p;
        }).toList(),

        // Remove change from machine stash
        coinsInMachine: () => Coinstack(coins: result.remainingCoins),

        // Add change to the return tray
        coinsInReturn: () => Coinstack(
          coins: _mergeCoinMaps(state.coinsInReturn.coins, result.usedCoins),
        ),

        // Reset user credit
        coinsInInput: () => Coinstack(),
      );

      print("Purchase successful!");
    } else {
      print("Machine cannot provide exact change!");
    }
  }

  /// Converts a price in cents to a formatted euro string.
  /// Example: 200 cents -> "2.00 €"
  String formatPriceToEuros(int priceInCents) {
    return '${(priceInCents / 100).toStringAsFixed(2)} €';
  }
}
