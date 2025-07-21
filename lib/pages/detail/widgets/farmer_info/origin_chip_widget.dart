import 'package:flutter/material.dart';
import 'package:today_s_farm/constants/app_colors.dart';

class OriginChipWidget extends StatelessWidget {
  final String origin;
  final String farmerName;

  const OriginChipWidget({
    Key? key,
    required this.origin,
    required this.farmerName,
  }) : super(key: key);

  Color _getOriginChipColor(String origin) {
    if (origin.contains('익산')) {
      return const Color(0xFFE3F2FD); // 연한 파랑
    } else if (origin.contains('평창')) {
      return const Color(0xFFF3E5F5); // 연한 보라
    } else if (origin.contains('청주')) {
      return const Color(0xFFE8F5E8); // 연한 초록
    } else if (origin.contains('서산')) {
      return const Color(0xFFFFF3E0); // 연한 주황
    } else if (origin.contains('강원')) {
      return const Color(0xFFE0F2F1); // 연한 청록
    } else if (origin.contains('고창')) {
      return const Color(0xFFFCE4EC); // 연한 분홍
    } else if (origin.contains('영양')) {
      return const Color(0xFFF1F8E9); // 연한 연두
    } else if (origin.contains('성주')) {
      return const Color(0xFFE8EAF6); // 연한 남색
    } else if (origin.contains('증평')) {
      return const Color(0xFFE0F7FA); // 연한 하늘
    } else {
      return const Color(0xFFE0E0E0); // 기본 회색
    }
  }

  Color _getOriginTextColor(String origin) {
    if (origin.contains('익산')) {
      return const Color(0xFF1976D2); // 진한 파랑
    } else if (origin.contains('평창')) {
      return const Color(0xFF7B1FA2); // 진한 보라
    } else if (origin.contains('청주')) {
      return const Color(0xFF388E3C); // 진한 초록
    } else if (origin.contains('서산')) {
      return const Color(0xFFF57C00); // 진한 주황
    } else if (origin.contains('강원')) {
      return const Color(0xFF00695C); // 진한 청록
    } else if (origin.contains('고창')) {
      return const Color(0xFFC2185B); // 진한 분홍
    } else if (origin.contains('영양')) {
      return const Color(0xFF689F38); // 진한 연두
    } else if (origin.contains('성주')) {
      return const Color(0xFF3F51B5); // 진한 남색
    } else if (origin.contains('증평')) {
      return const Color(0xFF0097A7); // 진한 하늘
    } else {
      return const Color(0xFF616161); // 기본 회색
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 원산지 Chip
        Chip(
          label: Text(
            origin,
            style: TextStyle(
              color: _getOriginTextColor(origin),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: _getOriginChipColor(origin),
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        const SizedBox(width: 8),
        // 농부 정보
        Text(
          '$farmerName 농부',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
