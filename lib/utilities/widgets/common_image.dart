import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/dimen_constant.dart';

class CommonImage extends StatelessWidget {
  final String imagePath;
  final bool isImageSVG;
  final BoxFit? boxFit;
  final double? width, height;
  final Color? imageColor;

  const CommonImage(
      {super.key,
      required this.imagePath,
      this.isImageSVG = false,
      this.width,
      this.boxFit,
      this.imageColor,
      this.height});

  @override
  Widget build(BuildContext context) {
    return isImageSVG
        ? SvgPicture.asset(
            imagePath,
            width: width ?? DimenConstants.dimen30.w,
            height: height ?? DimenConstants.dimen30.h,
            color: imageColor,
          )
        : Image.asset(
            imagePath,
            alignment: Alignment.center,
            fit: boxFit,
            width: width ?? DimenConstants.dimen30.w,
            height: height ?? DimenConstants.dimen30.h,
          );
  }
}
