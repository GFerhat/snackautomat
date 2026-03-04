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
  Product copyWith({
    String? id,
    String? name,
    int? count,
    int? price,
    String? url,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
      price: price ?? this.price,
      url: url ?? this.url,
    );
  }
}
