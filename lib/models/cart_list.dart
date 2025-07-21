import 'package:today_s_farm/models/cart_item.dart';
import 'package:today_s_farm/models/product_model.dart';

class CartList {
  final List<CartItem> _items;

  CartList({List<CartItem>? items}) : _items = items ?? [];

  List<CartItem> get items => List.unmodifiable(_items);

  // 장바구니에 상품 추가
  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere(
      (cartItem) => cartItem.product.id == item.product.id,
    );

    if (existingIndex != -1) {
      // 기존 상품이 있으면 수량 증가
      _items[existingIndex] = CartItem(
        product: _items[existingIndex].product,
        quantity: _items[existingIndex].quantity + item.quantity,
      );
    } else {
      // 새 상품 추가
      _items.add(item);
    }
  }

  // 장바구니에서 상품 제거
  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
  }

  // 상품 수량 업데이트
  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = CartItem(
          product: _items[index].product,
          quantity: quantity,
        );
      }
    }
  }

  // 상품 수량 1개 증가
  void incrementQuantity(String productId) {
    _updateItemQuantity(productId, (item) => item.incrementQuantity());
  }

  // 상품 수량 1개 감소 (최소 1개 유지)
  void decrementQuantity(String productId) {
    _updateItemQuantity(productId, (item) => item.decrementQuantity());
  }

  // 상품 수량 1개 증가 (제한 없음)
  void incrementQuantityUnlimited(String productId) {
    _updateItemQuantity(productId, (item) => item.incrementQuantityUnlimited());
  }

  // 상품 수량 1개 감소 (0까지 가능)
  void decrementQuantityToZero(String productId) {
    _updateItemQuantity(productId, (item) => item.decrementQuantityToZero());
  }

  // 내부 헬퍼 메서드
  void _updateItemQuantity(
    String productId,
    CartItem Function(CartItem) updateFn,
  ) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      final newItem = updateFn(_items[index]);
      if (newItem.quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = newItem;
      }
    }
  }

  // 장바구니 비우기
  void clear() {
    _items.clear();
  }

  // 총 개수
  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  // 총 가격
  int get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  // 장바구니가 비어있는지 확인
  bool get isEmpty => _items.isEmpty;

  // 장바구니에 상품이 있는지 확인
  bool get isNotEmpty => _items.isNotEmpty;

  // 특정 상품이 장바구니에 있는지 확인
  bool containsProduct(String productId) {
    return _items.any((item) => item.product.id == productId);
  }

  // 특정 상품의 수량 가져오기
  int getProductQuantity(String productId) {
    final item = _items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => throw ArgumentError('상품을 찾을 수 없습니다: $productId'),
    );
    return item.quantity;
  }

  // 장바구니 아이템 개수 (고유 상품 수)
  int get uniqueItemCount => _items.length;

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'items': _items
          .map(
            (item) => {
              'product': item.product.toJson(),
              'quantity': item.quantity,
            },
          )
          .toList(),
    };
  }

  // JSON에서 생성
  factory CartList.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>).map((itemJson) {
      return CartItem(
        product: Product.fromJson(itemJson['product'] as Map<String, dynamic>),
        quantity: itemJson['quantity'] as int,
      );
    }).toList();
    return CartList(items: items);
  }
}
