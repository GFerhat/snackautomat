import 'package:flutter/material.dart';
import 'coin_slot.dart';
import 'bill_slot.dart';
import 'card_slot.dart';
import 'coin_tray.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int totalCents = 0;
  int returnedCents = 0;

  List<int> insertedCoinValues = [];
  List<int> insertedBillValues = [];
  String? lastCoinImage;
  String? lastBillImage;

  void showCoinMenu() {
    final List<int> coinValues = [1, 2, 5, 10, 20, 50, 100, 200];
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: coinValues.map((value) {
            return ListTile(
              title: Text(value < 100 ? "$value ct" : "${value ~/ 100} €"),
              onTap: () {
                setState(() {
                  totalCents += value;
                  insertedCoinValues.add(value);
                  lastCoinImage = "assets/images/coins/coin_$value.png";
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void showBillMenu() {
    final List<int> billValues = [500, 1000, 2000, 5000];

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: billValues.map((value) {
            return ListTile(
              title: Text("${value ~/ 100} €"),
              onTap: () {
                setState(() {
                  totalCents += value;
                  insertedBillValues.add(value);
                  lastBillImage =
                      "assets/images/bills/bill_${value ~/ 100}.png";
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int insertedCoins = insertedCoinValues.length;
    final int insertedBills = insertedBillValues.length;

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
            onTap: showCoinMenu,
            imagePath: lastCoinImage,
          ),

          const SizedBox(height: 12),

          BillSlot(
            label: insertedBills == 0 ? "Bills" : "$insertedBills bills",
            color: insertedBills == 0
                ? Colors.grey.shade800
                : Colors.orange.shade600,
            onTap: showBillMenu,
            imagePath: lastBillImage,
          ),

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
                insertedBillValues.clear();
              });
            },
          ),

          const SizedBox(height: 16),

          // Text(
          //   "Coins: ${insertedCoinValues.map((v) => v < 100 ? "$v ct" : "${v ~/ 100}€").join(", ")}",
          //   style: const TextStyle(color: Colors.white70),
          // ),
          // Text(
          //   "Bills: ${insertedBillValues.map((v) => "${v ~/ 100}€").join(", ")}",
          //   style: const TextStyle(color: Colors.white70),
          // ),

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
                  offset: Offset(2, 2),
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
