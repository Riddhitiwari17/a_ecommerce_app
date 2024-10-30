import 'package:e_commerce_test/utilities/widgets/common_button.dart';
import 'package:e_commerce_test/utilities/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utilities/constants/color_constant.dart';
import '../../utilities/constants/dimen_constant.dart';
import '../../utilities/routes/route_constants.dart';
import 'custom_product_item.dart';
import 'product_controller.dart';

class ProductScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonTextWidget(
          text: 'Products',
          textColor: ColorConstants.blueTextColor,
        ),
        actions: [
          Obx(() {
            return productController.isLoggedIn.value
                ? IconButton(
                    icon: const Icon(
                      Icons.person,
                      color: ColorConstants.blueTextColor,
                    ),
                    onPressed: () {
                      Get.toNamed(RouteConstants.profileScreen);
                    },
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
      body: Column(children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimenConstants.dimen12.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(color: ColorConstants.blueTextColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DimenConstants.dimen12.r),
                  borderSide: const BorderSide(
                      color: ColorConstants.blueTextColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DimenConstants.dimen12.r),
                  borderSide: const BorderSide(
                      color: ColorConstants.blueTextColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DimenConstants.dimen12.r),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DimenConstants.dimen12.r),
                  borderSide: const BorderSide(color: Colors.orange, width: 2),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: ColorConstants.blueTextColor,
                  ),
                  onPressed: productController.toggleCategoryContainer,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              ),
              onChanged: (value) {
                productController.searchQuery.value = value;
              },
            ),
          ),
        ),
        Obx(() {
          return productController.isCategoryContainerVisible.value
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: DimenConstants.dimen16.sp),
                      ),
                      const Divider(),
                      ...productController.categoryList.map((category) {
                        return ListTile(
                          title: Text(
                            category.categoryName,
                            style: const TextStyle(
                                color: ColorConstants.blueTextColor),
                          ),
                          onTap: () {
                            productController.selectedCategory.value =
                                category.categoryName;
                            productController.toggleCategoryContainer();
                          },
                        );
                      }).toList(),
                    ],
                  ),
                )
              : const SizedBox.shrink();
        }),
        Expanded(
          child: Obx(() {
            if (productController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            var filteredProducts = productController.filteredProducts;
            if (filteredProducts.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                var product = filteredProducts[index];
                return CustomProductItem(product: product);
              },
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: DimenConstants.dimen10.h,
              horizontal: DimenConstants.dimen14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: CommonButton(
                  buttonText: 'Refresh',
                  primaryColor: ColorConstants.blueTextColor,
                  borderColor: ColorConstants.blueTextColor.withOpacity(0.2),
                  onButtonPressed: () {
                    productController.searchQuery.value = '';
                    productController.selectedCategory.value = '';
                    productController.getProductsFromApi();
                  },
                ),
              ),
              SizedBox(
                width: DimenConstants.dimen10.w,
              ),
              Expanded(
                child: CommonButton(
                  buttonText: 'Add to Bag',
                  primaryColor: ColorConstants.blueTextColor,
                  borderColor: ColorConstants.blueTextColor.withOpacity(0.2),
                  onButtonPressed: () {
                    Get.toNamed(RouteConstants.viewBagScreen,
                        arguments: productController.cartItems);
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
