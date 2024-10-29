import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/color_constant.dart';
import '../constants/dimen_constant.dart';
import 'common_text_widget.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final Function onButtonPressed;
  final Widget? iconWidget;
  final Color? foreGroundColor;
  final Color? textColor;
  final Color? primaryColor;
  final Color? borderColor;
  final FocusNode? currentFocusNode;
  final double? width, height;
  final double? btnTextSize, radius;
  final FontWeight? btnTextFontWeight;

  const CommonButton({
    Key? key,
    required this.buttonText,
    required this.onButtonPressed,
    this.iconWidget,
    this.foreGroundColor,
    this.primaryColor,
    this.currentFocusNode,
    this.width,
    this.height,
    this.btnTextSize,
    this.radius,
    this.textColor,
    this.borderColor,
    this.btnTextFontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          width: width ?? Get.width * 0.2,
          height: height ?? DimenConstants.dimen50.h,
        ),
        child: _elevatedButton());
  }

  Widget _elevatedButton() {
    return TextButton.icon(
      icon: iconWidget ?? const Text(""),
      focusNode: currentFocusNode,
      label: CommonTextWidget(
        text: buttonText,
        textColor: textColor ?? ColorConstants.whiteColor,
        // textColor: textColor ?? ColorConstant.whiteColor,
        fontSize: btnTextSize ?? DimenConstants.dimen16.sp,
        fontWeight: btnTextFontWeight ?? FontWeight.w500,
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              primaryColor ?? ColorConstants.buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    radius ?? DimenConstants.dimen8.r,
                  ),
                  side: BorderSide(
                    color: borderColor ?? ColorConstants.buttonColor,
                  )))),
      onPressed: () => onButtonPressed(),
    );
  }
}
