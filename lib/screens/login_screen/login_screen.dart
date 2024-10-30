import 'package:e_commerce_test/main.dart';
import 'package:e_commerce_test/utilities/constants/color_constant.dart';
import 'package:e_commerce_test/utilities/constants/dimen_constant.dart';
import 'package:e_commerce_test/utilities/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/routes/route_constants.dart';
import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.blueTextColor,
                ),
              ),
              const SizedBox(height: DimenConstants.dimen40),
              TextField(
                controller: loginController.usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle:
                      const TextStyle(color: ColorConstants.blueTextColor),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: ColorConstants.blueTextColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(DimenConstants.dimen12.r),
                    borderSide:
                        const BorderSide(color: ColorConstants.blueTextColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(DimenConstants.dimen12.r),
                    borderSide:
                        const BorderSide(color: ColorConstants.blueTextColor),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: DimenConstants.dimen20.h),
              Obx(() => TextField(
                    controller: loginController.passwordController,
                    decoration: InputDecoration(
                      labelStyle:
                          const TextStyle(color: ColorConstants.blueTextColor),
                      labelText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: ColorConstants.blueTextColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          color: ColorConstants.blueTextColor,
                          loginController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          loginController.togglePasswordVisibility();
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: ColorConstants.blueTextColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: ColorConstants.blueTextColor),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: !loginController.isPasswordVisible.value,
                  )),
              SizedBox(height: DimenConstants.dimen40.h),
              Obx(() => loginController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        loginController.login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.blueTextColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    )),
              SizedBox(height: DimenConstants.dimen100.h),
              InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  Get.offNamed(RouteConstants.productScreen);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorConstants.straightBtnColor.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(DimenConstants.dimen10.r)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CommonTextWidget(
                      text: "login without username",
                      textColor: ColorConstants.blueTextColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
