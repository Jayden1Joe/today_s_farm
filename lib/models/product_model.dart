import 'package:today_s_farm/utils/price_formatter.dart';

class Product {
  final String id;
  final String name;
  final int price;
  final String description;
  final String origin;
  final String? imageUrl;
  final String farmer;
  final int? deliveryDate; // 배송일
  final double? star; // 평점
  final int? reviewCount; // 리뷰 수

  Product({
    String? id,
    required this.name,
    required this.price,
    required this.description,
    required this.origin,
    this.imageUrl,
    required this.farmer,
    this.deliveryDate,
    this.star,
    this.reviewCount,
  }) : id = id ?? name; // id가 없으면 name을 id로 사용

  // JSON에서 Product 객체로 변환
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String?,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      origin: json['origin'] as String,
      imageUrl: json['imageUrl'] as String?,
      farmer: json['farmer'] as String,
      deliveryDate: json['deliveryDate'] as int?,
      star: json['star'] as double?,
      reviewCount: json['reviewCount'] as int?,
    );
  }

  // Product 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'origin': origin,
      'imageUrl': imageUrl,
      'farmer': farmer,
    };
  }

  // 가격을 포맷팅된 문자열로 반환
  String get formattedPrice => PriceFormatter.format(price);

  String get formattedDeliveryDate {
    if (deliveryDate == null) {
      return "배송일 정보 없음";
    } else if (deliveryDate == 1) {
      return "내일 도착";
    } else if (deliveryDate == 2) {
      return "이틀 뒤 도착";
    } else {
      return "$deliveryDate일 뒤 도착";
    }
  }

  // 상품 복사본 생성 (수정 시 사용)
  Product copyWith({
    String? id,
    String? name,
    int? price,
    String? description,
    String? imageUrl,
    String? origin,
    String? farmer,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      origin: origin ?? this.origin,
      farmer: farmer ?? this.farmer,
      deliveryDate: deliveryDate,
      star: star,
      reviewCount: reviewCount,
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
        other.origin == origin &&
        other.imageUrl == imageUrl &&
        other.farmer == farmer;
  }

  @override
  int get hashCode =>
      Object.hash(id, name, price, description, origin, imageUrl, farmer);
}
