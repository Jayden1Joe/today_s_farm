import 'package:flutter/material.dart';

class PartialStarRating extends StatelessWidget {
  final double rating; // ex. 4.2
  final double size;
  final Color filledColor;
  final Color unfilledColor;

  const PartialStarRating({
    super.key,
    required this.rating,
    this.size = 10,
    this.filledColor = const Color.fromARGB(255, 0, 0, 0),
    this.unfilledColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starFill = rating - index;
        if (starFill >= 1) {
          // fully filled
          return Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.star, size: size + 5, color: Colors.black),
              Icon(Icons.star, size: size, color: filledColor),
            ],
          );
        } else if (starFill > 0) {
          // partially filled
          return Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.star, size: size + 5, color: Colors.black),
              Icon(Icons.star, size: size, color: unfilledColor),
              ClipRect(
                clipper: _RatingClipper(percent: starFill.clamp(0.0, 1.0)),
                child: Icon(Icons.star, size: size, color: filledColor),
              ),
            ],
          );
        } else {
          // empty
          return Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.star, size: size + 5, color: Colors.black),
              Icon(Icons.star, size: size, color: unfilledColor),
            ],
          );
        }
      }),
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
