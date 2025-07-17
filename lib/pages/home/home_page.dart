import 'package:flutter/material.dart';
import 'package:today_s_farm/models/product_model.dart';
import 'package:today_s_farm/pages/add_product/add_product_page.dart';
import 'package:today_s_farm/pages/detail/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 예시 상품 데이터 (Product 클래스 사용)
    final List<Product> products = [
      Product(
        name: '상품 이름 1',
        price: 16000,
        description: '첫 번째 상품 설명',
        imageUrl: null,
      ),
      Product(name: '무료 샘플', price: 0, description: '무료 상품 설명', imageUrl: null),
      // 필요 시 더 추가...
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('상품 목록'), centerTitle: true),
      body: products.isEmpty
          ? const Center(child: Text('상품이 없습니다.'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          title: product.name,
                          description: product.description,
                          imageUrl: product.imageUrl,
                          price: product.price,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey.shade200,
                            child: product.imageUrl == null
                                ? const Icon(Icons.image, color: Colors.white54)
                                : Image.network(
                                    product.imageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.formattedPrice,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
