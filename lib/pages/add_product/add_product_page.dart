import 'package:flutter/material.dart';
import 'widgets/widget.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '상품 등록',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ImageSelectionWidget(),
            SizedBox(height: 32),
            ProductNameInputWidget(),
            SizedBox(height: 24),
            ProductPriceInputWidget(),
            SizedBox(height: 24),
            ProductDescriptionInputWidget(),
            SizedBox(height: 40),
            RegisterButtonWidget(),
          ],
        ),
      ),
    );
  }
}
