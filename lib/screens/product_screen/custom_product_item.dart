import 'package:e_commerce_test/main.dart';
import 'package:e_commerce_test/utilities/constants/dimen_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Assuming ProductController is defined somewhere else in your code
import 'package:get/get.dart';
import 'product_controller.dart';

class CustomProductItem extends StatelessWidget {
  final dynamic product;

  const CustomProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Center(
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                height: 200,
                width: double.infinity,
              ),
            ),
            SizedBox(height: DimenConstants.dimen16.h),
            Text(
              product.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: DimenConstants.dimen18.h),
            ),
            SizedBox(height: DimenConstants.dimen8.h),
            Text(
              '\$${product.price?.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: DimenConstants.dimen16.h),
            ElevatedButton.icon(
              onPressed: () {
                ProductController controller = Get.find();
                controller.addToCart(product);
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(double.infinity, DimenConstants.dimen40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
