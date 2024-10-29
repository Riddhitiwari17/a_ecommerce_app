import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

class CommonTextWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final int? maxLine;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;

  const CommonTextWidget(
      {Key? key,
      required this.text,
      this.textColor,
      this.fontSize,
      this.maxLine,
      this.textAlign,
      this.textOverflow,
      this.textDecoration,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      emptyNullText(),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLine,
      overflow: textOverflow,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize,
        decoration:textDecoration,
        color: textColor ?? ColorConstants.textColor,
      ),
    );
  }

  String emptyNullText() {
    if (text.toString() == "null" ||
        text.toString() == "NULL" ||
        text.toString() == " ") {
      return " ";
    } else {
      return text;
    }
  }
}
