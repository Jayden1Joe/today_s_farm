class Product {
  final String name;
  final int price;
  final String description;
  final String? imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.description,
    this.imageUrl,
  });

  // JSON에서 Product 객체로 변환
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  // Product 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  // 가격을 포맷팅된 문자열로 반환
  String get formattedPrice {
    if (price == 0) return '무료';
    return '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원';
  }

  // 상품 복사본 생성 (수정 시 사용)
  Product copyWith({
    String? name,
    int? price,
    String? description,
    String? imageUrl,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'Product(name: $name, price: $price, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.name == name &&
        other.price == price &&
        other.description == description &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => Object.hash(name, price, description, imageUrl);
}
