import 'package:flutter/foundation.dart';
import 'package:today_s_farm/models/cart_item.dart';
import 'package:today_s_farm/models/cart_list.dart';
import 'package:today_s_farm/models/product_model.dart';

class CartProvider with ChangeNotifier {
  CartList _cart = CartList();

  // CartList의 모든 getter를 직접 위임
  CartList get cart => _cart;
  List<CartItem> get items => _cart.items;
  int get totalPrice => _cart.totalPrice;
  int get totalItems => _cart.totalItems;
  bool get isEmpty => _cart.isEmpty;
  bool get isNotEmpty => _cart.isNotEmpty;
  int get uniqueItemCount => _cart.uniqueItemCount;

  // 장바구니에 상품 추가
  void addItem(Product product, {int quantity = 1}) {
    _cart.addItem(CartItem(product: product, quantity: quantity));
    notifyListeners();
  }

  // 장바구니에서 상품 제거
  void removeItem(String productId) {
    _cart.removeItem(productId);
    notifyListeners();
  }

  // 상품 수량 업데이트
  void updateQuantity(String productId, int quantity) {
    _cart.updateQuantity(productId, quantity);
    notifyListeners();
  }

  // 상품 수량 1개 증가
  void incrementQuantity(String productId) {
    _cart.incrementQuantity(productId);
    notifyListeners();
  }

  // 상품 수량 1개 감소 (최소 1개 유지)
  void decrementQuantity(String productId) {
    _cart.decrementQuantity(productId);
    notifyListeners();
  }

  // 상품 수량 1개 증가 (제한 없음)
  void incrementQuantityUnlimited(String productId) {
    _cart.incrementQuantityUnlimited(productId);
    notifyListeners();
  }

  // 상품 수량 1개 감소 (0까지 가능)
  void decrementQuantityToZero(String productId) {
    _cart.decrementQuantityToZero(productId);
    notifyListeners();
  }

  // 장바구니 비우기
  void clear() {
    _cart.clear();
    notifyListeners();
  }

  // 특정 상품이 장바구니에 있는지 확인
  bool containsProduct(String productId) => _cart.containsProduct(productId);

  // 특정 상품의 수량 가져오기 (안전한 버전)
  int getProductQuantity(String productId) {
    try {
      return _cart.getProductQuantity(productId);
    } catch (e) {
      return 0;
    }
  }

  // JSON으로 저장
  Map<String, dynamic> toJson() {
    return _cart.toJson();
  }

  // JSON에서 복원
  void fromJson(Map<String, dynamic> json) {
    _cart = CartList.fromJson(json);
    notifyListeners();
  }
}
