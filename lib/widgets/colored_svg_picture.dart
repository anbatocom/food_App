import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ColoredSvgPicture extends StatelessWidget {
  final String path;
  final Color color;
  final bool isSelected;

  const ColoredSvgPicture({
    required this.path,
    required this.color,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
          isSelected ? const Color(0xFFDB166E) : color, BlendMode.srcIn),
    );
  }
}
