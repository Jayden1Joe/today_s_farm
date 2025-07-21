import 'package:flutter/material.dart';
import 'package:today_s_farm/constants/app_colors.dart';
import 'package:today_s_farm/utils/data_products.dart';
import 'package:today_s_farm/models/product_model.dart';
import 'package:today_s_farm/pages/add_product/add_product_page.dart';
import 'package:today_s_farm/pages/cart/cart_page.dart';
import 'package:today_s_farm/pages/detail/detail_page.dart';
import 'package:today_s_farm/utils/star_icon_formatter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> productList = List.from(DataProducts.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '오늘의 밭',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productList.isEmpty ? 1 : productList.length + 1,
        itemBuilder: (context, index) {
          if (productList.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text('상품이 없습니다.', style: TextStyle(fontSize: 16)),
              ),
            );
          }

          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 4, 0, 4),
              child: Text(
                '오늘 아침 수확했어요!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          final product = productList[index - 1];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailPage(product: product)),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            child: product.imageUrl == null
                                ? const Icon(Icons.image, color: Colors.white54)
                                : Image.asset(
                                    product.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.image,
                                      color: Colors.white54,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product.origin} · ${product.farmer} 농부",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 3),
                        RichText(
                          text: TextSpan(
                            text: product.formattedPriceWithoutUnit,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: '원',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        RichText(
                          text: TextSpan(
                            text: "예상배송일 ",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: product.formattedDeliveryDate,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            PartialStarRating(rating: product.star!),
                            Text(
                              '${product.star}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddProductPage()),
            );

            if (result != null && result is Product) {
              setState(() {
                productList.insert(0, result);
              });
            }
          },
          label: const Text(
            '상품 추가하기',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final String text;
  final bool enabled;

  const Badge({super.key, required this.text, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: enabled ? Colors.grey[300] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: enabled ? Colors.black : Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}
