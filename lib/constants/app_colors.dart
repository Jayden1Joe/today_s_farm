import 'package:flutter/material.dart';

/// 앱 전체에서 사용하는 색상 상수들을 정의하는 클래스
///
/// 사용 예시:
/// ```dart
/// Container(
///   color: AppColors.primary,
///   child: Text('Hello', style: TextStyle(color: AppColors.textPrimary)),
/// )
/// ```
class AppColors {
  // 기본 브랜드 색상
  static const Color primary = Color(0xFF6D9F4B); // 따뜻한 초록
  static const Color secondary = Color(0xFFFFB74D); // 오렌지빛 포인트

  // 배경 색상
  static const Color background = Color(0xFFFFFBEF); // 크림톤 배경
  static const Color surface = Color(0xFFF5F2E7); // 카드/입력창 배경

  // 텍스트 색상
  static const Color textPrimary = Color(0xFF2E2E2E); // 본문 텍스트
  static const Color textSecondary = Color(0xFF7C7C7C); // 설명 텍스트

  // 상태 색상
  static const Color error = Color(0xFFD32F2F); // 에러/삭제 등
  static const Color success = Color(0xFF4CAF50); // 성공/완료
  static const Color warning = Color(0xFFFF9800); // 경고
  static const Color info = Color(0xFF2196F3); // 정보

  // 구분선 색상
  static const Color divider = Color(0xFFE0E0E0); // 구분선
  static const Color border = Color(0xFFCBCBCB); // 테두리

  // 별점 색상
  static const Color starFilled = Color(0xFFFFD700); // 채워진 별
  static const Color starEmpty = Color(0xFFE0E0E0); // 빈 별

  // 버튼 색상
  static const Color buttonPrimary = Color(0xFF6D9F4B); // 주요 버튼
  static const Color buttonSecondary = Color(0xFFFFB74D); // 보조 버튼
  static const Color buttonDisabled = Color(0xFFBDBDBD); // 비활성화 버튼

  // 카드 색상
  static const Color cardBackground = Color(0xFFFFFFFF); // 카드 배경
  static const Color cardShadow = Color(0x1A000000); // 카드 그림자

  // 입력 필드 색상
  static const Color inputBackground = Color(0xFFF5F2E7); // 입력 필드 배경
  static const Color inputBorder = Color(0xFFE0E0E0); // 입력 필드 테두리
  static const Color inputFocus = Color(0xFF6D9F4B); // 입력 필드 포커스

  // 네비게이션 색상
  static const Color navigationBackground = Color(0xFFFFFFFF); // 네비게이션 배경
  static const Color navigationSelected = Color(0xFF6D9F4B); // 선택된 네비게이션
  static const Color navigationUnselected = Color(0xFF7C7C7C); // 선택되지 않은 네비게이션
}
