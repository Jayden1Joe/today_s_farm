import 'package:flutter/material.dart';
import 'package:today_s_farm/models/product_model.dart';

// 이미지 선택 위젯
class ImageSelectionWidget extends StatelessWidget {
  const ImageSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImageSelectionDialog(context);
      },
      child: Container(
        width: double.infinity,
        height: 200,
        color: Colors.grey[300],
        child: const Center(child: Text('Image 선택')),
      ),
    );
  }

  void _showImageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('이미지 선택'),
          content: const Text('이미지가 선택되었습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}

// 상품 이름 입력 위젯
class ProductNameInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const ProductNameInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('상품 이름'),
        const SizedBox(width: 16),
        Expanded(child: TextField(controller: controller)),
      ],
    );
  }
}

// 상품 가격 입력 위젯
class ProductPriceInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const ProductPriceInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('상품 가격'),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 8),
        const Text('원'),
      ],
    );
  }
}

// 상품 설명 입력 위젯
class ProductDescriptionInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const ProductDescriptionInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('상품 설명'),
        const SizedBox(height: 8),
        TextField(controller: controller, maxLines: 5),
      ],
    );
  }
}

// 등록하기 버튼 위젯
class RegisterButtonWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;

  const RegisterButtonWidget({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 가격이 숫자인지 확인
          if (priceController.text.isNotEmpty &&
              !RegExp(r'^\d+$').hasMatch(priceController.text)) {
            _showNumberInputDialog(context);
            return;
          }

          // 필수 필드가 비어있는지 확인
          if (nameController.text.isEmpty ||
              priceController.text.isEmpty ||
              descriptionController.text.isEmpty) {
            _showEmptyFieldDialog(context);
            return;
          }

          _showRegistrationCompleteDialog(context);
        },
        child: const Text('등록하기'),
      ),
    );
  }

  void _showNumberInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('입력 오류'),
          content: const Text('가격은 숫자만 입력해주세요.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void _showEmptyFieldDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('입력 오류'),
          content: const Text('모든 필드를 입력해주세요.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void _showRegistrationCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('등록 완료'),
          content: const Text('상품이 성공적으로 등록되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                // Product 객체 생성
                final newProduct = Product(
                  name: nameController.text,
                  price: int.parse(priceController.text),
                  description: descriptionController.text,
                  imageUrl: null, // 이미지 선택 기능은 나중에 구현
                );

                Navigator.of(context).pop(); // 다이얼로그 닫기
                Navigator.of(context).pop(newProduct); // 홈페이지로 Product 객체 반환
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
