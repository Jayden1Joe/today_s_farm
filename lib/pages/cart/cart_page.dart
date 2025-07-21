import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_s_farm/providers/cart_provider.dart';
import 'package:today_s_farm/models/product_model.dart';
import 'package:today_s_farm/utils/price_formatter.dart';

// class CartItem {
//   final Product product;
//   int quantity;

//   CartItem({required this.product, this.quantity = 1});

//   int get totalPrice => product.price * quantity;
// }

// class CartProvider with ChangeNotifier {
//   final List<CartItem> _items = [];

//   List<CartItem> get items => _items;

//   int get totalCartPrice {
//     return _items.fold(0, (sum, item) => sum + item.totalPrice);
//   }

//   void addItem(Product product, int quantity) {
//     // 이미 장바구니에 있는지 확인
//     final index = _items.indexWhere(
//       (item) => item.product.name == product.name,
//     );

//     if (index >= 0) {
//       _items[index].quantity += quantity;
//     } else {
//       _items.add(CartItem(product: product, quantity: quantity));
//     }
//     notifyListeners();
//   }

//   void removeItem(String productName) {
//     _items.removeWhere((item) => item.product.name == productName);
//     notifyListeners();
//   }

//   void incrementQuantity(String productName) {
//     final index = _items.indexWhere((item) => item.product.name == productName);
//     if (index >= 0 && _items[index].quantity < 99) {
//       _items[index].quantity++;
//       notifyListeners();
//     }
//   }

//   void decrementQuantity(String productName) {
//     final index = _items.indexWhere((item) => item.product.name == productName);
//     if (index >= 0 && _items[index].quantity > 1) {
//       _items[index].quantity--;
//       notifyListeners();
//     }
//   }
// }

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  String _formatPrice(int price) => PriceFormatter.format(price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '장바구니',
          style: TextStyle(
            color: Color(0xFF222222),
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        leading: const BackButton(color: Color(0xFF222222)),
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFFF8FAF3),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: const Text(
              '내일 도착 예정',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF222222),
              ),
            ),
          ),
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                if (cartProvider.items.isEmpty) {
                  return const Center(child: Text('장바구니가 비어있습니다.'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  itemCount: cartProvider.items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = cartProvider.items[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: item.product.imageUrl != null
                                ? Image.asset(
                                    item.product.imageUrl!,
                                    width: 140,
                                    height: 140,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        _buildImagePlaceholder(size: 140),
                                  )
                                : _buildImagePlaceholder(size: 140),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            flex: 12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Color(0xFF222222),
                                  ),
                                ),
                                if (item.product.description != null &&
                                    item.product.description!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 14.0,
                                    ),
                                    child: Text(
                                      item.product.description!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF888888),
                                      ),
                                    ),
                                  ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFE0E0E0),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xFFF8FAF3),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove,
                                              size: 18,
                                            ),
                                            splashRadius: 18,
                                            onPressed: () =>
                                                cartProvider.decrementQuantity(
                                                  item.product.id,
                                                ),
                                          ),
                                          Text(
                                            '${item.quantity}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              size: 18,
                                            ),
                                            splashRadius: 18,
                                            onPressed: () =>
                                                cartProvider.incrementQuantity(
                                                  item.product.id,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        size: 22,
                                        color: Color(0xFF888888),
                                      ),
                                      splashRadius: 18,
                                      onPressed: () => cartProvider.removeItem(
                                        item.product.id,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  _formatPrice(item.totalPrice),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Color(0xFF222222),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildPurchaseButton(
            context,
            Provider.of<CartProvider>(context, listen: false),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder({double size = 56}) {
    return Container(
      width: size,
      height: size,
      color: Colors.grey.shade300,
      child: const Icon(Icons.image, color: Colors.white54, size: 44),
    );
  }

  Widget _buildPurchaseButton(BuildContext context, CartProvider cartProvider) {
    if (cartProvider.items.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF8FAF3),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: () {
            // 구매 처리 로직
          },
          child: Text(
            '총 ${_formatPrice(cartProvider.totalPrice)} 구매하기',
            style: const TextStyle(
              color: Color(0xFF6BA16C),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
