// 이미지 선택 위젯
import 'package:flutter/material.dart';

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
        height: 240,
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
