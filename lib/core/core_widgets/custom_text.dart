import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextStyle? style;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    required this.text,
    this.style,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          style ??
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
      textDirection: textDirection,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
