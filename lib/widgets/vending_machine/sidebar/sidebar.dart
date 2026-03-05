import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_snackautomat/provider/app_state_provider.dart';
import 'coin_slot.dart';
import 'card_slot.dart';
import 'coin_tray.dart';
import 'insert_money_window.dart';
import 'package:flutter_snackautomat/widgets/vending_machine/sidebar/coin_selection_sheet.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final notifier = ref.read(appStateProvider.notifier);

    final int totalCents = appState.coinsInInput.totalValue;
    final int insertedCoins = appState.coinsInInput.coins.values.fold(
      0,
      (sum, count) => sum + count,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF1E1E1E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CoinSlot(
            label: insertedCoins == 0 ? "Coins" : "$insertedCoins coins",
            color: insertedCoins == 0
                ? Colors.grey.shade800
                : Colors.green.shade600,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const CoinSelectionSheet(),
              );
            },
            imagePath: null,
          ),
          const SizedBox(height: 12),

          // --- Card Slot ---
          CardSlot(
            label: "Card Slot",
            color: Colors.grey.shade800,
            imagePath: "assets/images/cards/card.png",
          ),

          const SizedBox(height: 16),

          // --- Coin Tray / Return ---
          const CoinTray(),

          const SizedBox(height: 16),

          // --- Total Anzeige ---
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(255, 96, 116, 106),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              "Total: ${(totalCents / 100).toStringAsFixed(2)} €",
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 112, 119, 115),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
