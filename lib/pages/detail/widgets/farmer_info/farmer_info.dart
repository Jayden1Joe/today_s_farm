import 'package:flutter/material.dart';
import 'package:today_s_farm/models/product_model.dart';
import 'package:today_s_farm/pages/detail/widgets/farmer_info/origin_chip_widget.dart';
import 'package:today_s_farm/pages/detail/widgets/farmer_info/star_rating_widget.dart';

class FarmerInfo extends StatelessWidget {
  final Product product;

  const FarmerInfo({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OriginChipWidget(origin: product.origin, farmerName: product.farmer),
        StarRatingWidget(rating: product.star ?? 0.0),
      ],
    );
  }
}
