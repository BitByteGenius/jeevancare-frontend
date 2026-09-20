class ProductModel {
  final String id;
  final String name;
  final String packSize;
  final double rating;
  final int? ratingCount;
  final String imageUrl;
  final double price;
  final double mrp;
  final int discountPercent;
  final String deliveryEta;
  final double? carePlanPrice;
  final double? carePlanThreshold;
  final String category;
  final bool inStock;
  final bool isBestSeller;

  const ProductModel({
    required this.id,
    required this.name,
    required this.packSize,
    required this.rating,
    this.ratingCount,
    required this.imageUrl,
    required this.price,
    required this.mrp,
    required this.discountPercent,
    required this.deliveryEta,
    this.carePlanPrice,
    this.carePlanThreshold = 1200,
    required this.category,
    this.inStock = true,
    this.isBestSeller = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      packSize: json['packSize'] as String,
      rating: (json['rating'] as num).toDouble(),
      ratingCount: json['ratingCount'] as int?,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      mrp: (json['mrp'] as num).toDouble(),
      discountPercent: json['discountPercent'] as int,
      deliveryEta: json['deliveryEta'] as String,
      carePlanPrice: (json['carePlanPrice'] as num?)?.toDouble(),
      carePlanThreshold: (json['carePlanThreshold'] as num?)?.toDouble() ?? 1200,
      category: json['category'] as String,
      inStock: json['inStock'] as bool? ?? true,
      isBestSeller: json['isBestSeller'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'packSize': packSize,
      'rating': rating,
      'ratingCount': ratingCount,
      'imageUrl': imageUrl,
      'price': price,
      'mrp': mrp,
      'discountPercent': discountPercent,
      'deliveryEta': deliveryEta,
      'carePlanPrice': carePlanPrice,
      'carePlanThreshold': carePlanThreshold,
      'category': category,
      'inStock': inStock,
      'isBestSeller': isBestSeller,
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? packSize,
    double? rating,
    int? ratingCount,
    String? imageUrl,
    double? price,
    double? mrp,
    int? discountPercent,
    String? deliveryEta,
    double? carePlanPrice,
    double? carePlanThreshold,
    String? category,
    bool? inStock,
    bool? isBestSeller,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      packSize: packSize ?? this.packSize,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      mrp: mrp ?? this.mrp,
      discountPercent: discountPercent ?? this.discountPercent,
      deliveryEta: deliveryEta ?? this.deliveryEta,
      carePlanPrice: carePlanPrice ?? this.carePlanPrice,
      carePlanThreshold: carePlanThreshold ?? this.carePlanThreshold,
      category: category ?? this.category,
      inStock: inStock ?? this.inStock,
      isBestSeller: isBestSeller ?? this.isBestSeller,
    );
  }
}
