import 'package:e_commerce_test/main.dart';
import 'package:e_commerce_test/utilities/constants/color_constant.dart';
import 'package:e_commerce_test/utilities/constants/dimen_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utilities/widgets/common_text_widget.dart';
import '../checkout_screen/checkout_screen.dart';
import 'view_bag_controller.dart';

class ViewBagScreen extends StatelessWidget {
  final ViewBagController controller = Get.put(ViewBagController());

  ViewBagScreen({super.key});

  double calculateTotal() {
    double total = 0.0;
    for (var item in controller.cartItems) {
      total += item.product.price! * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const CommonTextWidget(
        text: 'View Cart',
        textColor: ColorConstants.blueTextColor,
      )),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty.'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return Card(
                    color: ColorConstants.whiteColor,
                    elevation: 0.5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(DimenConstants.dimen16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.network(
                              item.product.image,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: DimenConstants.dimen8.h),
                          Text(
                            item.product.title,
                            style: TextStyle(
                              fontSize: DimenConstants.dimen16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: DimenConstants.dimen8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${item.product.price?.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstants.straightBtnColor
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove,
                                            color: ColorConstants.blueTextColor,
                                          ),
                                          onPressed: () => controller
                                              .decrementQuantity(index),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            '${item.quantity}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                            color: ColorConstants.blueTextColor,
                                          ),
                                          onPressed: () => controller
                                              .incrementQuantity(index),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(() {
                    return Text(
                      '\$${calculateTotal().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    );
                  }),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(CheckoutScreen()); // Navigate to CheckoutScreen
                  },
                  child: const Text('Checkout'),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
