import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../checkout_screen/checkout_screen.dart';
import 'view_bag_controller.dart';

class ViewBagScreen extends StatelessWidget {
  final ViewBagController controller = Get.put(ViewBagController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Cart')),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(child: Text('Your cart is empty.'));
        }

        return ListView.builder(
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            final item = controller.cartItems[index];
            return ListTile(
              leading: Image.network(item.product.image),
              title: Text(item.product.title),
              subtitle: Text('\$${item.product.price?.toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => controller.decrementQuantity(index),
                  ),
                  Text('${item.quantity}'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => controller.incrementQuantity(index),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Get.to(CheckoutScreen()); // Navigate to CheckoutScreen
        },
        child: Text('Checkout'),
      )
        ,
    );
  }
}
