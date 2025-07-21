import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_s_farm/constants/app_colors.dart';
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

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _formatPrice(int price) => PriceFormatter.format(price);

  String _formatPriceWithoutUnit(int price) =>
      PriceFormatterWithOutUnit.format(price);

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
      body: SafeArea(
        child: Column(
          children: [
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                if (cartProvider.items.isEmpty) return const SizedBox.shrink();
                return Container(
                  width: double.infinity,
                  color: const Color(0xFFF8FAF3),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: const Text(
                    '내일 도착 예정',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF222222),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  if (cartProvider.items.isEmpty) {
                    return const Center(
                      child: Text(
                        '장바구니가 비어있습니다.',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    itemCount: cartProvider.items.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = cartProvider.items[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ), // 좌우 16px 여백 추가
                        padding: EdgeInsets.zero, // 내부 여백 최소화
                        constraints: const BoxConstraints(
                          minHeight: 96,
                        ), // 세로 크기 줄임
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
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              child: item.product.imageUrl != null
                                  ? Image.asset(
                                      item.product.imageUrl!,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          _buildImagePlaceholder(
                                            size: 150,
                                            width: 150,
                                          ),
                                    )
                                  : _buildImagePlaceholder(
                                      size: 160,
                                      width: 120,
                                    ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ), // 세로 패딩 줄임
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.product.origin} · '
                                      '${item.product.farmer} 농부',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Color(0xFF222222),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 32, // 세로 높이 납작하게
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFE0E0E0),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ), // 원형 유지
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.remove,
                                                  size: 18, // 기존 크기 유지
                                                ),
                                                splashRadius: 18, // 기존 크기 유지
                                                onPressed: () {
                                                  setState(() {});
                                                  cartProvider
                                                      .decrementQuantity(
                                                        item.product.id,
                                                      );
                                                },
                                              ),
                                              Text(
                                                '${item.quantity}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15, // 복원
                                                  color: Color(0xFF222222),
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.add,
                                                  size: 18, // 기존 크기 유지
                                                ),
                                                splashRadius: 18, // 기존 크기 유지
                                                onPressed: () {
                                                  setState(() {});
                                                  cartProvider
                                                      .incrementQuantity(
                                                        item.product.id,
                                                      );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            size: 22,
                                            color: AppColors.textPrimary,
                                          ),
                                          splashRadius: 18,
                                          onPressed: () {
                                            setState(() {});
                                            cartProvider.removeItem(
                                              item.product.id,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    RichText(
                                      text: TextSpan(
                                        text: _formatPriceWithoutUnit(
                                          item.totalPrice,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' 원',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }

  Widget _buildImagePlaceholder({double size = 56, double? width}) {
    return Container(
      width: width ?? size,
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
            backgroundColor: AppColors.buttonPrimary, // 진한 녹색
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  contentPadding: const EdgeInsets.all(24),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '구매가 완료되었습니다.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text(
                          '쇼핑 계속 하기',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Text(
            '총 ${_formatPrice(cartProvider.totalPrice)} 구매하기',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
