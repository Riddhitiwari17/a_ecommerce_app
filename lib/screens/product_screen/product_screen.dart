import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/routes/route_constants.dart';
import 'custom_product_item.dart';
import 'product_controller.dart';

class ProductScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Column(children: [
        // Dropdown for selecting category

        // Search Bar (Optional)
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                ),
                onChanged: (value) {
                  productController.searchQuery.value = value;
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Obx(() {
                return Align(
                  alignment: Alignment.centerRight,
                  child: DropdownButton<String>(
                    icon: const Icon(Icons.sort),
                    alignment: Alignment.centerRight,
                    value: productController.selectedCategory.value.isEmpty
                        ? null
                        : productController.selectedCategory.value,
                    onChanged: (String? newValue) {
                      productController.selectedCategory.value = newValue ?? '';
                    },
                    underline:
                        Container(), // Use an empty Container to remove the underline
                    items: productController.categoryList
                        .map<DropdownMenuItem<String>>((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
          ],
        ),

        // List of products
        Expanded(
          child: Obx(() {
            if (productController.isLoading.value)
              return Center(child: CircularProgressIndicator());

            var filteredProducts = productController.filteredProducts;

            if (filteredProducts.isEmpty) {
              return Center(
                  child: Text('No products found')); // Handle no products case
            }

            return ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                var product = filteredProducts[index];
                return CustomProductItem(
                    product: product); // Use the custom widget here
              },
            );
          }),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to ViewBagScreen and pass the cart items
          Get.toNamed(RouteConstants.viewBagScreen,
              arguments: productController.cartItems);
        },
        child: Icon(Icons.shopping_bag),
      ),
    );
  }
}
