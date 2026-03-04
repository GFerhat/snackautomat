class Product {
  final String id;
  final String name;
  final int count;
  final int price;
  final String? url;

  Product({
    required this.id,
    required this.name,
    required this.count,
    required this.price,
    this.url,
  });
}