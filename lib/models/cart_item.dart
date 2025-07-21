import 'package:today_s_farm/models/product_model.dart';
import 'package:today_s_farm/utils/price_formatter.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  // 총 가격 계산
  int get totalPrice => product.price * quantity;

  // 포맷된 총 가격
  String get formattedTotalPrice => PriceFormatter.format(totalPrice);

  // 수량 1개 증가
  CartItem incrementQuantity() => _withQuantity(quantity + 1);

  // 수량 1개 감소 (최소 1개 유지)
  CartItem decrementQuantity() {
    if (quantity <= 1) return this;
    return _withQuantity(quantity - 1);
  }

  // 수량 1개 증가 (제한 없음)
  CartItem incrementQuantityUnlimited() => _withQuantity(quantity + 1);

  // 수량 1개 감소 (0까지 가능)
  CartItem decrementQuantityToZero() {
    if (quantity <= 0) return this;
    return _withQuantity(quantity - 1);
  }

  // 내부 헬퍼 메서드
  CartItem _withQuantity(int newQuantity) {
    return CartItem(
      product: product,
      quantity: newQuantity,
    );
  }

  // 수량 설정
  CartItem withQuantity(int newQuantity) {
    if (newQuantity <= 0) {
      throw ArgumentError('수량은 0보다 커야 합니다.');
    }
    return CartItem(
      product: product,
      quantity: newQuantity,
    );
  }

  // 상품 복사본 생성
  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() {
    return 'CartItem(product: ${product.name}, quantity: $quantity, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.product.id == product.id &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => Object.hash(product.id, quantity);
}
