import 'package:flutter/material.dart';

class EasyTextWidget extends StatelessWidget {
  const EasyTextWidget(
      {Key? key,
      required this.text,
      this.color = Colors.white,
      this.fontSize = 20,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
