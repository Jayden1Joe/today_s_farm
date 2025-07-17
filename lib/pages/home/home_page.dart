import 'package:flutter/material.dart';
import 'package:today_s_farm/models/product_list.dart';
import 'package:today_s_farm/models/product_model.dart';
import 'package:today_s_farm/pages/add_product/add_product_page.dart';
import 'package:today_s_farm/pages/detail/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> productList = List.from(products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상품 목록'), centerTitle: true),
      body: productList.isEmpty
          ? const Center(child: Text('상품이 없습니다.'))
          : ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
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
                                : Image.asset(
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
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );

          // 등록 완료 후 새로운 상품을 목록 맨 위에 추가
          if (result != null && result is Product) {
            setState(() {
              productList.insert(0, result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
