import 'package:flutter/material.dart';
import 'widgets/widget.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('상품 등록'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageSelectionWidget(),
            const SizedBox(height: 24),
            ProductNameInputWidget(controller: nameController),
            const SizedBox(height: 16),
            ProductPriceInputWidget(controller: priceController),
            const SizedBox(height: 16),
            ProductDescriptionInputWidget(controller: descriptionController),
            const SizedBox(height: 32),
            RegisterButtonWidget(
              nameController: nameController,
              priceController: priceController,
              descriptionController: descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}
