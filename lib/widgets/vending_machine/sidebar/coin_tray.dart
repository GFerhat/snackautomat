import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_snackautomat/provider/app_state_provider.dart';

class CoinTray extends ConsumerWidget {
  const CoinTray({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final notifier = ref.read(appStateProvider.notifier);

    final returnedCoinsTotal = appState.coinsInReturn.totalValue;
    final returnedCoinsCount = appState.coinsInReturn.coins.values.fold(
      0,
      (sum, count) => sum + count,
    );

    final label = returnedCoinsTotal == 0
        ? "Return Tray"
        : "${(returnedCoinsTotal / 100).toStringAsFixed(2)} €";

    return InkWell(
      onTap: returnedCoinsTotal > 0
          ? () {
              notifier.clearCointray();
            }
          : null,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF0E0E0E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: returnedCoinsTotal > 0
                ? Colors.orange.shade600
                : Colors.grey.shade700,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            if (returnedCoinsCount > 0)
              Text(
                "$returnedCoinsCount coins",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
