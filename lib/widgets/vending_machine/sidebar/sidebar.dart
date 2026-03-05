import 'package:flutter/material.dart';
import 'coin_slot.dart';
import 'card_slot.dart';
import 'coin_tray.dart';
import 'insert_money_window.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int totalCents = 0;
  int returnedCents = 0;

  List<int> insertedCoinValues = [];
  String? lastCoinImage;

  @override
  Widget build(BuildContext context) {
    final int insertedCoins = insertedCoinValues.length;

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
                builder: (_) => InsertMoneyWindow(
                  coinValues: [1, 2, 5, 10, 20, 50, 100, 200],
                  billValues: [500, 1000, 2000, 5000],
                  onInsert: (value) {
                    setState(() {
                      totalCents += value;
                      if (value < 500) {
                        insertedCoinValues.add(value);
                        lastCoinImage = "assets/images/coins/coin_$value.png";
                      }
                    });
                  },
                ),
              );
            },
            imagePath: lastCoinImage,
          ),

          const SizedBox(height: 12),

          const SizedBox(height: 12),

          CardSlot(
            label: "Card Slot",
            color: Colors.grey.shade800,
            imagePath: "assets/images/cards/card.png",
          ),

          const SizedBox(height: 16),

          CoinTray(
            label: "Return",
            color: Colors.grey.shade700,
            onTap: () {
              setState(() {
                returnedCents += totalCents;
                totalCents = 0;
                insertedCoinValues.clear();
              });
            },
          ),

          const SizedBox(height: 16),

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
