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
      appBar: AppBar(
        title: const Text('장바구니'),
        leading: const BackButton(),
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.items.isEmpty) {
            return const Center(child: Text('장바구니가 비어있습니다.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.items[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: item.product.imageUrl != null
                                ? Image.asset(
                                    item.product.imageUrl!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        _buildImagePlaceholder(),
                                  )
                                : _buildImagePlaceholder(),
                          ),
                          const SizedBox(width: 16),
                          Expanded(child: Text(item.product.name)),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => cartProvider
                                    .decrementQuantity(item.product.id),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => cartProvider
                                    .incrementQuantity(item.product.id),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Text(_formatPrice(item.totalPrice)),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () =>
                                cartProvider.removeItem(item.product.id),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              _buildPurchaseButton(context, cartProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 60,
      height: 60,
      color: Colors.grey.shade300,
      child: const Icon(Icons.image, color: Colors.white54),
    );
  }

  Widget _buildPurchaseButton(BuildContext context, CartProvider cartProvider) {
    if (cartProvider.items.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: () {
          // 구매 처리 로직
        },
        child: Text('총 ${_formatPrice(cartProvider.totalPrice)} 구매하기'),
      ),
    );
  }
}
