import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_snackautomat/models/product.dart';
import 'package:flutter_snackautomat/provider/app_state.dart';

class AppStateNotifier extends Notifier<AppState> {
  AppState build() => AppState(
    coinsInInput: Coinstack(),
    coinsInMachine: Coinstack(),
    coinsInReturn: Coinstack(),
    products: [Product(id: 'id', name: 'name', count: 3)],
  );

  void inputCoin(int value) {
    final coins = {...state.coinsInInput.coins};
    coins[value] = (coins[value] ?? 0) + 1;
    final newInput = Coinstack(coins: coins);
    state = state.copyWith(coinsInInput: () => newInput);
  }
}
