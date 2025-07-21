import 'package:flutter/material.dart';
import 'package:today_s_farm/pages/add_product/widgets/add_text_field.dart';
import 'package:today_s_farm/pages/add_product/widgets/image_selection.dart';
import 'widgets/register_button.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController originController = TextEditingController();
  final TextEditingController farmerController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    originController.dispose();
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: RegisterButton(
              nameController: nameController,
              priceController: priceController,
              originController: originController,
              descriptionController: descriptionController,
              farmerController: farmerController,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageSelectionWidget(),

            const SizedBox(height: 16),
            AddTextField(controller: farmerController, label: '생산자 성함'),
            const SizedBox(height: 16),
            AddTextField(controller: nameController, label: '상품 이름'),
            const SizedBox(height: 16),
            AddTextField(
              controller: priceController,
              label: '상품 가격',
              suffixText: '원',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            AddTextField(controller: originController, label: '상품 원산지'),
            const SizedBox(height: 16),
            AddTextField(
              controller: descriptionController,
              label: '상품 설명',
              maxLines: 10,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
