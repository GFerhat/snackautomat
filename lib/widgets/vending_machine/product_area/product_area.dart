import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_snackautomat/models/product.dart';
import 'package:flutter_snackautomat/provider/app_state_provider.dart';

class ProductArea extends ConsumerWidget {
  const ProductArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStateWatch = ref.watch(appStateProvider);
    final products = appStateWatch.products;

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: List.generate(
        9,
        (index) {
          final hasProduct = index < products.length;
          final product = hasProduct ? products[index] : null;
          return _buildProductSlot(context, index, product, ref);
        },
      ),
    );
  }

  Widget _buildProductSlot(
    BuildContext context,
    int index,
    Product? product,
    WidgetRef ref,
  ) {
    final isAvailable = product != null && product.count > 0;
    final notifier = ref.read(appStateProvider.notifier);

    return Container(
      margin: EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          if (isAvailable) {
            _showBuyDialog(context, ref, product);
            print("you tapped on snackslot #${index + 1} - ${product.name}");
          }
        },
        borderRadius: BorderRadius.zero,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${index + 1}'),
              if (isAvailable)
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              else
                Text(
                  'Empty',
                  style: TextStyle(color: Colors.grey),
                ),
              if (isAvailable)
                Text(
                  notifier.formatPriceToEuros(product.price),
                  style: TextStyle(color: Colors.green),
                )
              else
                Text(
                  '- €',
                  style: TextStyle(color: Colors.grey),
                ),
              if (isAvailable)
                Text('In stock: ${product.count}')
              else
                Text(
                  'No item',
                  style: TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBuyDialog(BuildContext context, WidgetRef ref, Product product) {
    final notifier = ref.read(appStateProvider.notifier);
    final userCredit = ref.read(appStateProvider).coinsInInput.totalValue;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Price: ${notifier.formatPriceToEuros(product.price)}'),
              Text('In stock: ${product.count}'),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                if (userCredit < product.price) {
                  // show alert
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Please insert money'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'inserted: ${notifier.formatPriceToEuros(userCredit)}',
                          ),
                          Text(
                            'product cost: ${notifier.formatPriceToEuros(product.price)}',
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  notifier.purchaseProduct(product);
                  Navigator.pop(context);
                }
              },
              child: Text('BUY'),
              textColor: Colors.green,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }
}
