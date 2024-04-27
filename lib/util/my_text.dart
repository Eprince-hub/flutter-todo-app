import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final bool taskCompleted;

  const MyText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.maxLines = 1,
    this.taskCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration:
            taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
