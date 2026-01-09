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
  int coins = 0;
  int bills = 0;
  int returnedCoins = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CoinSlot(
          label: "Coins: $coins",
          color: Colors.green,
          onTap: () {
            setState(() {
              coins += 1;
            });
          },
        ),
        BillSlot(
          label: "Bills: $bills",
          color: Colors.yellow,
          onTap: () {
            setState(() {
              bills += 1;
            });
          },
        ),
        CardSlot(label: "Card Slot", color: Colors.redAccent),
        CoinTray(
          label: "Returned: $returnedCoins",
          color: Colors.blue,
          onTap: () {
            setState(() {
              returnedCoins += coins + bills;
              coins = 0;
              bills = 0;
            });
          },
        ),
      ],
    );
  }
}
