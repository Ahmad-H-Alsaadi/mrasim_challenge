class ProductsModel {
  final int? id;
  final String name;
  final String imageUrl;
  final double price;
  final DateTime createdAt;

  ProductsModel({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      price: map['price'] is int ? (map['price'] as int).toDouble() : map['price'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
    );
  }

  ProductsModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    double? price,
    DateTime? createdAt,
  }) {
    return ProductsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
