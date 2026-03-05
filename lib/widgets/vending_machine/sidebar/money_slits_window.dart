import 'package:flutter/material.dart';

class MoneySlitsWindow extends StatelessWidget {
  final List<int> coinValues;
  final void Function(int) onInsert;

  const MoneySlitsWindow({
    super.key,
    required this.coinValues,
    required this.onInsert,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[900],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Money Slits",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: coinValues.map((v) {
              return ElevatedButton(
                onPressed: () {
                  onInsert(v);
                  Navigator.pop(context);
                },
                child: Text(v < 100 ? "$v ct" : "${v ~/ 100} €"),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
