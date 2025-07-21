import 'package:today_s_farm/utils/price_formatter.dart';

class Product {
  final String id;
  final String name;
  final int price;
  final String description;
  final String? imageUrl;

  Product({
    String? id,
    required this.name,
    required this.price,
    required this.description,
    this.imageUrl,
  }) : id = id ?? name; // id가 없으면 name을 id로 사용

  // JSON에서 Product 객체로 변환
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String?,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  // Product 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // 가격을 포맷팅된 문자열로 반환
  String get formattedPrice => PriceFormatter.format(price);

  // 상품 복사본 생성 (수정 시 사용)
  Product copyWith({
    String? id,
    String? name,
    int? price,
    String? description,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => Object.hash(id, name, price, description, imageUrl);
}
