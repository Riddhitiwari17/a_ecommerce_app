import 'package:e_commerce_test/utilities/constants/color_constant.dart';
import 'package:e_commerce_test/utilities/routes/route_constants.dart';
import 'package:e_commerce_test/utilities/routes/route_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: ColorConstants.backgroundColor,
          ),
          initialRoute: RouteConstants.loginScreen,
          getPages: RouteScreens.routes,
        );
      },
    );
  }
}
