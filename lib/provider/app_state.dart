import 'package:flutter_snackautomat/models/coinstack.dart';
import 'package:flutter_snackautomat/models/product.dart';

class AppState {
  final Coinstack coinsInMachine;
  final Coinstack coinsInReturn;
  final Coinstack coinsInInput;
  final Product? selectedProduct;
  final List<Product> products;
  final List<Product> purchasedItems;

  const AppState({
    required this.coinsInMachine,
    required this.coinsInReturn,
    required this.coinsInInput,
    this.selectedProduct,
    required this.products,
    this.purchasedItems = const [],
  });

  AppState copyWith({
    Coinstack Function()? coinsInMachine,
    Coinstack Function()? coinsInReturn,
    Coinstack Function()? coinsInInput,
    Product? Function()? selectedProduct,
    List<Product> Function()? products,
    List<Product> Function()? purchasedItems,
  }) => AppState(
    coinsInMachine: coinsInMachine == null
        ? this.coinsInMachine
        : coinsInMachine(),
    coinsInReturn: coinsInReturn == null ? this.coinsInReturn : coinsInReturn(),
    coinsInInput: coinsInInput == null ? this.coinsInInput : coinsInInput(),
    selectedProduct: selectedProduct == null
        ? this.selectedProduct
        : selectedProduct(),
    products: products == null ? this.products : products(),
    purchasedItems: purchasedItems == null
        ? this.purchasedItems
        : purchasedItems(),
  );
}
