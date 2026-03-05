import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snackautomat/provider/app_state_provider.dart';

class SuspensionSlot extends ConsumerWidget {
  const SuspensionSlot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchasedItems = ref.watch(appStateProvider).purchasedItems;

    final hasItems = purchasedItems.isNotEmpty;

    return InkWell(
      onTap: hasItems ? () => _showPurchasedItemsDialog(context, ref) : null,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hasItems
                    ? "Product Dispensing Area - ${purchasedItems.length} item${purchasedItems.length > 1 ? 's' : ''} ready"
                    : "Product Dispensing Area",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: hasItems ? Colors.greenAccent : Colors.deepOrangeAccent,
          boxShadow: hasItems
              ? [
                  BoxShadow(
                    color: Colors.greenAccent.withValues(alpha: 0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 0),
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  void _showPurchasedItemsDialog(BuildContext context, WidgetRef ref) {
    final purchasedItems = ref.read(appStateProvider).purchasedItems;
    final notifier = ref.read(appStateProvider.notifier);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Purchased Items'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: purchasedItems.length,
              itemBuilder: (context, index) {
                final item = purchasedItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(notifier.formatPriceToEuros(item.price)),
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                notifier.clearPurchasedItems();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
