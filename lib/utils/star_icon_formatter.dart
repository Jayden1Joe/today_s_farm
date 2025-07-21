import 'package:flutter/material.dart';

class PartialStarRating extends StatelessWidget {
  final double rating; // ex. 4.2
  final double size;
  final Color filledColor;
  final Color unfilledColor;

  const PartialStarRating({
    super.key,
    required this.rating,
    this.size = 15,
    this.filledColor = const Color.fromARGB(255, 0, 0, 0),
    this.unfilledColor = const Color.fromARGB(255, 214, 214, 214),
  });

  @override
  Widget build(BuildContext context) {
    final percent = (rating / 5.0).clamp(0.0, 1.0); // 0.0 ~ 1.0

    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (_) => Icon(Icons.star, color: unfilledColor, size: size),
          ),
        ),
        ClipRect(
          clipper: _RatingClipper(percent: percent),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              5,
              (_) => Stack(
                alignment: Alignment.center,
                children: [Icon(Icons.star, size: size, color: filledColor)],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RatingClipper extends CustomClipper<Rect> {
  final double percent; // 0.0 ~ 1.0

  _RatingClipper({required this.percent});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * percent, size.height);
  }

  @override
  bool shouldReclip(_RatingClipper oldClipper) {
    return oldClipper.percent != percent;
  }
}
