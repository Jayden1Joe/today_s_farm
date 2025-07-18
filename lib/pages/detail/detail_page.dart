import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_s_farm/models/product_model.dart';
import 'package:today_s_farm/pages/cart/cart_page.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1;

  void _increment() {
    if (_quantity < 99) {
      setState(() => _quantity++);
    }
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  void _addToCart() {
    final cart = context.read<CartProvider>();
    cart.addItem(widget.product, _quantity);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('장바구니에 담겼습니다.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.product.price * _quantity;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        title: Text(widget.product.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          widget.product.imageUrl != null
              ? Container(
                  width: double.infinity,
                  child: Image.asset(
                    widget.product.imageUrl!,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade300,
                      width: double.infinity,
                      height: 300,
                      child: const Center(child: Text('Image')),
                    ),
                  ),
                )
              : Container(
                  color: Colors.grey.shade300,
                  width: double.infinity,
                  height: 300,
                  child: const Center(child: Text('이미지가 없습니다')),
                ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.name, style: const TextStyle(fontSize: 18)),
                Text(
                  widget.product.formattedPrice,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Text(
                  widget.product.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            IconButton(onPressed: _decrement, icon: const Icon(Icons.remove)),
            Text('$_quantity', style: const TextStyle(fontSize: 16)),
            IconButton(onPressed: _increment, icon: const Icon(Icons.add)),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('총 가격', style: TextStyle(fontSize: 14)),
                Text(
                  '${totalPrice.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')}원',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _addToCart,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('장바구니 담기'),
            ),
          ],
        ),
      ),
    );
  }
}
