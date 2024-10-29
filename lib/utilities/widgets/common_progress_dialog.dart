import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/color_constant.dart';
import '../constants/dimen_constant.dart';
import '../constants/string_constant.dart';

OverlayEntry? _progressOverlayEntry;

showProgressDialog() {
  _progressOverlayEntry = _createdSuccessProgressEntry();
  StringConstants.isProgressShow = true;
  Overlay.of(Get.overlayContext as BuildContext).insert(_progressOverlayEntry!);
}

hideProgressDialog() {
  if (_progressOverlayEntry != null) {
    _progressOverlayEntry!.remove();
    _progressOverlayEntry = null;
    StringConstants.isProgressShow = false;
  }
}

OverlayEntry _createdSuccessProgressEntry() => OverlayEntry(
    builder: (BuildContext context) => Stack(children: <Widget>[
          Container(
              height: Get.height,
              width: Get.width,
              color: ColorConstants.blackColor.withOpacity(0.4),
              child: Align(
                  alignment: Alignment.center,
                  child: Center(
                      child: Lottie.asset(StringConstants.loader,
                          height: DimenConstants.dimen100.h +
                              DimenConstants.dimen50.h,
                          width: DimenConstants.dimen100.w +
                              DimenConstants.dimen50.w))))
        ]));
