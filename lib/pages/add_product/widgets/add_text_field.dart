// 상품 이름 입력 위젯
import 'package:flutter/material.dart';
import 'package:today_s_farm/constants/app_colors.dart';

class AddTextField extends StatelessWidget {
  const AddTextField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLines,
    this.suffixText,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final int? maxLines;
  final String? suffixText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //bottom border line
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(fontSize: 16),
            focusColor: AppColors.inputFocus,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.inputBorder, width: 1.7),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.inputFocus, width: 1.7),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            suffixIcon: suffixText != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(suffixText!),
                  )
                : null,
            suffixIconConstraints: BoxConstraints(),
          ),
          keyboardType: keyboardType,
          controller: controller,
        ),
      ],
    );
  }
}
