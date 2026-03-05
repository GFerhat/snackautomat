import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_snackautomat/provider/app_state_provider.dart';

class SuspensionSlot extends ConsumerWidget {
  const SuspensionSlot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final returnedCoinsTotal = appState.coinsInReturn.totalValue;
    final returnedCoinsCount = appState.coinsInReturn.coins.values.fold(
      0,
      (sum, count) => sum + count,
    );

    return Container(
      padding: EdgeInsets.all(3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            returnedCoinsTotal == 0
                ? "Coin Tray - Empty"
                : "Coin Tray - ${(returnedCoinsTotal / 100).toStringAsFixed(2)} € ($returnedCoinsCount coins)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: returnedCoinsTotal == 0 ? Colors.grey : Colors.white,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.deepOrangeAccent),
    );
  }
}
