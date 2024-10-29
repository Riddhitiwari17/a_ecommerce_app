import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../login_screen/;ogin_screen.dart';
import '../login_screen/auth_controller.dart';

class CheckoutScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController()); // Get instance of AuthController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Center(
        child: Obx(() {
          if (authController.isLoggedIn.value) {
            // User is logged in, show payment methods
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Payment Methods"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle payment
                    Get.snackbar("Payment", "Payment processed successfully!");
                  },
                  child: Text('Pay Now'),
                ),
              ],
            );
          } else {
            // User is not logged in, show login prompt
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You need to log in to proceed."),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(LoginScreen()); // Navigate to LoginScreen
                  },
                  child: Text('Login'),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
