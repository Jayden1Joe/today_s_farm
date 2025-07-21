import 'package:flutter/material.dart';
import 'package:today_s_farm/constants/app_colors.dart';
import 'package:today_s_farm/models/product_model.dart';

// 등록하기 버튼 위젯
class RegisterButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController originController;
  final TextEditingController farmerController;

  const RegisterButton({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
    required this.originController,
    required this.farmerController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // 필수 필드가 비어있는지 확인
        if (_isNotEmpty() || _isNotNumber()) {
          _showDialog(context);
          return;
        }
        _showCompleteDialog(context);
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        padding: EdgeInsets.zero,
      ),
      child: const Text('등록'),
    );
  }

  bool _isNotNumber() =>
      priceController.text.isNotEmpty &&
      !RegExp(r'^\d+$').hasMatch(priceController.text);
  bool _isNotEmpty() =>
      farmerController.text.isEmpty ||
      nameController.text.isEmpty ||
      priceController.text.isEmpty ||
      originController.text.isEmpty ||
      descriptionController.text.isEmpty;

  void _showDialog(BuildContext context) {
    String resultText = "";
    if (farmerController.text.isEmpty) {
      resultText = "생산자 성함을";
    } else if (nameController.text.isEmpty) {
      resultText = "상품 이름을";
    } else if (priceController.text.isEmpty) {
      resultText = "가격을";
    } else if (originController.text.isEmpty) {
      resultText = "상품 원산지를";
    } else if (descriptionController.text.isEmpty) {
      resultText = "상품 설명을";
    } else if (_isNotNumber()) {
      resultText = "가격을 숫자로";
    } else {
      resultText = "상품 원산지를";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('입력 오류'),
          content: Text('$resultText 입력해주세요.'),
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

  void _showCompleteDialog(BuildContext context) {
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
                // final String id;
                // final String name;
                // final int price;
                // final String description;
                // final String origin;
                // final String? imageUrl;
                // final String farmer;
                // final int? deliveryDate; // 배송일
                // final double? star; // 평점
                // final int? reviewCount; //
                final newProduct = Product(
                  name: nameController.text,
                  price: int.parse(priceController.text),
                  description: descriptionController.text,
                  origin: originController.text,
                  imageUrl: null, // 이미지 선택 기능은 나중에 구현
                  farmer: farmerController.text,
                  deliveryDate: null,
                  star: null,
                  reviewCount: 0,
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
