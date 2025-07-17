import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 예시 상품 데이터
    final List<Map<String, dynamic>> products = [
      {'name': '상품 이름 1', 'price': 16000, 'imageUrl': null},
      {'name': '상품 이름 2', 'price': 0, 'imageUrl': null},
      {'name': '상품 이름 2', 'price': 0, 'imageUrl': null},
      {'name': '상품 이름 2', 'price': 0, 'imageUrl': null},
      {'name': '상품 이름 2', 'price': 0, 'imageUrl': null},
      {'name': '상품 이름 2', 'price': 0, 'imageUrl': null},
      {'name': '상품 이름 2', 'price': 0, 'imageUrl': null},
      {'name': '상품 이름 2', 'price': 0, 'imageUrl': null},
      {'name': '상품 이름 2', 'price': 0, 'imageUrl': null},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('TITLE'), centerTitle: true),
      body: products.isEmpty
          ? const Center(child: Text('상품이 없습니다.'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                // 가격 포맷: 0원은 "무료", 나머지는 천 단위 콤마
                final priceText = product['price'] == 0
                    ? '무료'
                    : '${product['price'].toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')} 원';

                return GestureDetector(
                  onTap: () {
                    // 상세 페이지 이동 처리 예정
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                        ), //아이템 간 구분선
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey.shade300,
                            child: product['imageUrl'] == null
                                ? const Icon(Icons.image, color: Colors.white54)
                                : Image.network(
                                    product['imageUrl'],
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product['name']),
                              const SizedBox(height: 4),
                              Text(priceText),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 상품 등록 페이지 이동 처리 예정
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
