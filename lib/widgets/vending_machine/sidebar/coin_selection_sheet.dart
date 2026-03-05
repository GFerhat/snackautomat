import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snackautomat/provider/app_state_provider.dart';

class CoinSelectionSheet extends ConsumerWidget {
  const CoinSelectionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final credit = appState.credit;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Insert Coins",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            "Credit: ${(credit / 100).toStringAsFixed(2)} €",
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 10,
            children: [
              coinButton(ref, 5),
              coinButton(ref, 10),
              coinButton(ref, 20),
              coinButton(ref, 50),
              coinButton(ref, 100),
              coinButton(ref, 200),
            ],
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              ref
                  .read(appStateProvider.notifier)
                  .clearInput(); // setzt coinsInInput zurück
              Navigator.pop(context);
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }
}

Widget coinButton(WidgetRef ref, int value) {
  return ElevatedButton(
    onPressed: () {
      ref.read(appStateProvider.notifier).inputCoin(value);
    },
    child: Text(value >= 100 ? "${value ~/ 100}€" : "${value}ct"),
  );
}
