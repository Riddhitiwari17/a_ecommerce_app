import 'package:e_commerce_test/utilities/constants/color_constant.dart';
import 'package:e_commerce_test/utilities/constants/dimen_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utilities/widgets/common_text_widget.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonTextWidget(
          text: 'Products',
          textColor: ColorConstants.blueTextColor,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: ColorConstants.blueTextColor,
            ),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.userData.isEmpty) {
          return const Center(child: Text('No profile data found.'));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: DimenConstants.dimen14.h),
              _commonTextField(
                label: 'Name',
                value:
                    '${controller.userData['name']['firstname']} ${controller.userData['name']['lastname']}',
              ),
              SizedBox(height: DimenConstants.dimen14.h),
              _commonTextField(
                label: 'Username',
                value: controller.userData['username'],
              ),
              SizedBox(height: DimenConstants.dimen14.h),
              _commonTextField(
                label: 'Email',
                value: controller.userData['email'],
              ),
              SizedBox(height: DimenConstants.dimen14.h),
              _commonTextField(
                label: 'Address',
                value: '${controller.userData['address']['street']}, '
                    '${controller.userData['address']['city']}, '
                    '${controller.userData['address']['zipcode']}',
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _commonTextField({required String label, required String value}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimenConstants.dimen12.r),
        color: Colors.white,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstants.blueTextColor,
          ),
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        readOnly: true,
        initialValue: value,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                controller.logOut();
              },
            ),
          ],
        );
      },
    );
  }
}
