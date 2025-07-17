import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [
    CartItem(name: '상품 이름 1', price: 16000, quantity: 1),
    CartItem(name: '상품 이름 2', price: 16000, quantity: 1),
    CartItem(name: '상품 이름 1', price: 16000, quantity: 1),
  ];

  void incrementQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TITLE'),
        leading: const BackButton(),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('장바구니가 비어있습니다.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 이미지
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.image,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // 상품 이름 + 수량 조절
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () =>
                                            decrementQuantity(index),
                                      ),
                                      Container(
                                        width: 32,
                                        alignment: Alignment.center,
                                        child: Text('${item.quantity}'),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () =>
                                            incrementQuantity(index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // 가격
                            Text(
                              '${item.price.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')} 원',
                            ),
                            const SizedBox(width: 12),
                            // 삭제 버튼
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => removeItem(index),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (cartItems.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // 구매 처리
                      },
                      child: const Text('구매하기'),
                    ),
                  ),
              ],
            ),
    );
  }
}

class CartItem {
  final String name;
  final int price;
  int quantity;

  CartItem({required this.name, required this.price, this.quantity = 1});
}
