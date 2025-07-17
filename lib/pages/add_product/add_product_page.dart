import 'package:flutter/material.dart';
import 'widgets/widget.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('TITLE'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ImageSelectionWidget(),
            SizedBox(height: 24),
            ProductNameInputWidget(),
            SizedBox(height: 16),
            ProductPriceInputWidget(),
            SizedBox(height: 16),
            ProductDescriptionInputWidget(),
            SizedBox(height: 32),
            RegisterButtonWidget(),
          ],
        ),
      ),
    );
  }
}
