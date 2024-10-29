import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constant.dart';
import '../constants/dimen_constant.dart';
import 'common_text_widget.dart';

class CommonAppBar {
  final IconData? iconData;
  final double? iconSize;
  final Color? bgColor, iconColor;
  final Color? textColor;
  final double? textSize;
  final Function? onIconClicked;
  final String? title;

  CommonAppBar(
      {this.iconData,
        this.iconSize,
        this.iconColor,
        this.textSize,
        this.bgColor,
        this.title,
        this.onIconClicked,
        this.textColor});

  AppBar appBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.whiteColor,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Builder(
            builder: (context) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (onIconClicked != null) {
                        Get.back();
                      } else {
                        Get.back();
                      }
                    },
                    icon: Icon(
                      iconData ?? Icons.arrow_back_ios,
                      color: iconColor ?? Colors.black,
                      size: iconSize,
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: CommonTextWidget(
                    text: title ?? "",
                    fontSize: DimenConstants.dimen20,
                    textColor: ColorConstants.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )));
  }
}
