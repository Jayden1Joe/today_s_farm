import 'package:flutter/material.dart';

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
  const ProductNameInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('상품 이름'),
        const SizedBox(width: 16),
        Expanded(child: TextField()),
      ],
    );
  }
}

// 상품 가격 입력 위젯
class ProductPriceInputWidget extends StatelessWidget {
  const ProductPriceInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('상품 가격'),
        const SizedBox(width: 16),
        Expanded(child: TextField(keyboardType: TextInputType.number)),
        const SizedBox(width: 8),
        const Text('원'),
      ],
    );
  }
}

// 상품 설명 입력 위젯
class ProductDescriptionInputWidget extends StatelessWidget {
  const ProductDescriptionInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('상품 설명'),
        const SizedBox(height: 8),
        TextField(maxLines: 5),
      ],
    );
  }
}

// 등록하기 버튼 위젯
class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          _showRegistrationCompleteDialog(context);
        },
        child: const Text('등록하기'),
      ),
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
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // 이전 페이지로 돌아가기
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
