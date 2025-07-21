import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_s_farm/providers/cart_provider.dart';
import 'package:today_s_farm/models/product_model.dart';
import 'package:today_s_farm/utils/price_formatter.dart';
import 'package:today_s_farm/constants/app_colors.dart';

class BottomBar extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;
  final Animation<double>? animation;

  const BottomBar({
    Key? key,
    required this.product,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onAddToCart,
    required this.onBuyNow,
    this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalPrice = product.price * quantity;

    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        return Positioned(
          bottom: animation!.value * -10 - (1 - animation!.value) * 200,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardBackground, // 배경색 - 흰색 카드
              border: Border(
                top: BorderSide(
                  color: AppColors.divider,
                  width: 1,
                ), // 구분선 색상 변경
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    // 수량 선택기
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.divider, // 입력 필드 구분선 색상 변경
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: quantity > 1 ? onDecrement : null,
                            icon: Icon(
                              Icons.remove,
                              size: 24,
                              color: quantity > 1
                                  ? AppColors
                                        .divider // 색상 변경
                                  : AppColors.divider, // 비활성화 색상
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary, // 색상 변경
                            ),
                          ),
                          IconButton(
                            onPressed: quantity < 99 ? onIncrement : null,
                            icon: Icon(
                              Icons.add,
                              size: 24,
                              color: quantity < 99
                                  ? AppColors
                                        .textPrimary // 색상 변경
                                  : AppColors.divider, // 비활성화 색상
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // 총 가격
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '총 가격',
                          style: TextStyle(
                            color: AppColors.textSecondary, // 색상 변경
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          PriceFormatter.format(totalPrice),
                          style: TextStyle(
                            color: AppColors.primary, // 총 가격 색상 - 초록색
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 버튼들
                Row(
                  children: [
                    // 장바구니 담기 버튼
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onAddToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary, // 버튼 색상 - 초록색
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                              color: AppColors.primary, // 버튼 색상 - 초록색
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          '장바구니 담기',
                          style: TextStyle(
                            color: AppColors.primary, // 버튼 색상 - 초록색
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // 바로 구매 버튼
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onBuyNow,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary, // 버튼 색상 - 초록색
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          '바로 구매',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
