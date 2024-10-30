import 'package:e_commerce_test/utilities/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utilities/constants/color_constant.dart';
import '../../utilities/constants/dimen_constant.dart';
import '../../utilities/widgets/common_text_widget.dart';
import '../login_screen/login_screen.dart';
import '../login_screen/auth_controller.dart';

class CheckoutScreen extends StatelessWidget {
  final LoginController authController = Get.put(LoginController());

  CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    authController.checkLoginStatus();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Center(
        child: Obx(() {
          if (authController.isLoggedIn.value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CommonTextWidget(
                    text: "Payment Methods",
                    textColor: ColorConstants.blueTextColor,
                  ),
                ),
                SizedBox(height: DimenConstants.dimen20.h),
                ElevatedButton(
                  onPressed: () {
                    Get.snackbar("Payment", "Payment processed successfully!");
                  },
                  child: const Text('Pay Now'),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ColorConstants.straightBtnColor.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(DimenConstants.dimen10.r)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CommonTextWidget(
                      text: "You need to log in to proceed.",
                      textColor: ColorConstants.blueTextColor,
                    ),
                  ),
                ),
                SizedBox(height: DimenConstants.dimen20.h),
                ElevatedButton(
                  onPressed: () {
                    Get.offNamed(RouteConstants.loginScreen);
                  },
                  child: const Text('Login'),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
