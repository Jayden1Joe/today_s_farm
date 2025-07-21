import 'package:flutter/material.dart';
import 'package:today_s_farm/utils/star_icon_formatter.dart';
import 'package:today_s_farm/constants/app_colors.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color? filledColor;
  final Color? unfilledColor;

  const StarRatingWidget({
    Key? key,
    required this.rating,
    this.size = 21,
    this.filledColor,
    this.unfilledColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PartialStarRating(
          rating: rating,
          size: size,
          filledColor: filledColor ?? AppColors.starFilled,
          unfilledColor: unfilledColor ?? AppColors.starEmpty,
        ),
        const SizedBox(width: 8),
        Text(
          rating.toString(),
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
