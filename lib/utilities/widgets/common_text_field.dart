import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../constants/color_constant.dart';
import '../constants/dimen_constant.dart';

class CommonTextField extends StatelessWidget {
  final FocusNode? currentFocusNode, nextFocusNode;
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final String hintText;
  final int? minLines;
  final int? maxInput;
  final bool isMandatory;
  final String? allowedRegex;
  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final bool? isEnabled, readOnly;
  final bool? isPassword;
  final bool? isFilled;
  final Color? fillColor;
  final Color? iconColor;
  final String? Function(String?)? validatorFunction;
  final String? Function(String?)? onChanged;
  final List<TextInputFormatter>? textInputFormatter;
  final RxBool isPasswordIconClicked = false.obs;
  final double? borderRadius;
  final double? borderWidth;
  final double? hintSize;
  final Function? onPrefixIconPress;
  final Function? onFieldSubmitted;

  // final Function? onSuffixIconPress;
  final EdgeInsets? contentPadding;

  CommonTextField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    this.minLines,
    this.maxInput,
    this.isMandatory = false,
    this.prefixIcon,
    this.suffixWidget,
    this.currentFocusNode,
    this.nextFocusNode,
    this.allowedRegex,
    this.keyboardType,
    this.isEnabled,
    this.readOnly,
    this.isPassword,
    this.validatorFunction,
    this.textInputFormatter,
    this.isFilled,
    this.fillColor,
    this.borderRadius,
    this.hintSize,
    this.borderWidth,
    this.iconColor,
    this.onPrefixIconPress,
    this.contentPadding,
    this.onFieldSubmitted,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _textField();
  }

  Widget _textField() {
    return Obx(() => TextFormField(
        onChanged: onChanged,
        focusNode: currentFocusNode,
        controller: textEditingController,
        autovalidateMode: AutovalidateMode.disabled,
        inputFormatters: textInputFormatter,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.done,
        readOnly: readOnly ?? false,
        enabled: isEnabled ?? true,
        validator: validatorFunction,
        maxLength: maxInput,
        obscureText:
        isPassword != null ? _decideObsure() : isPasswordIconClicked.value,
        minLines: minLines ?? 1,
        maxLines: minLines == null ? 1 : null,
        onFieldSubmitted: (_) {
          try {
            if (onFieldSubmitted != null) {
              onFieldSubmitted!();
            }
            currentFocusNode?.unfocus();
            if (nextFocusNode != null) {
              FocusScope.of(
                Get.context as BuildContext,
              ).requestFocus(nextFocusNode);
            }
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        },
        decoration: InputDecoration(
            label: RichText(
                text: TextSpan(
                    text: hintText,
                    style: TextStyle(
                        fontSize: DimenConstants.dimen12.sp,
                        fontFamily: "Poppins",
                        color: ColorConstants.textColor),
                    children: [
                      if (isMandatory == true)
                        const TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.red,
                            ))
                    ])),
            counterText: "",
            fillColor: fillColor ?? const Color(0xffEFEFEF),
            filled: isFilled ?? false,
            contentPadding: contentPadding,
            labelStyle:
            TextStyle(fontSize: hintSize ?? DimenConstants.dimen10.sp),
            prefixIcon: prefixIcon != null
                ? IconButton(
                onPressed: () => onPrefixIconPress!(),
                icon: Icon(
                  prefixIcon,
                  color: iconColor ?? Colors.blue[400],
                ))
                : null,
            suffixIcon: _suffixIconWidget(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConstants.textFormFieldBorderColor,
                    width: borderWidth ?? 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? DimenConstants.dimen10.r),
                )),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConstants.textFormFieldBorderColor,
                    width: borderWidth ?? 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? DimenConstants.dimen10.r),
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConstants.textFormFieldBorderColor,
                    width: borderWidth ?? 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? DimenConstants.dimen10.r),
                )),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConstants.textFormFieldBorderColor,
                    width: borderWidth ?? 0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? DimenConstants.dimen10.r),
                )))));
  }

  Widget? _suffixIconWidget() {
    if (suffixWidget != null) {
      return suffixWidget;
    } else if (isPassword == true) {
      return Obx(
            () => InkWell(
            onTap: () =>
            isPasswordIconClicked.value = !isPasswordIconClicked.value,
            child: Icon(FontAwesomeIcons.eye,
                size: DimenConstants.dimen14.h,
                color: isPasswordIconClicked.value
                    ? ColorConstants.primaryColor
                    : ColorConstants.textColor)),
      );
    } else {
      return null;
    }
  }

  bool _decideObsure() {
    if (isPassword == true) {
      if (isPasswordIconClicked.value) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
