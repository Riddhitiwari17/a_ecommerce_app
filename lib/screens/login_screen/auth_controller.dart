import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs; // Track the user's login status

  // Method to log in the user
  void login(String username, String password) {
    if (username.isNotEmpty && password.isNotEmpty) {
      isLoggedIn.value = true; // Set login status to true
      Get.snackbar("Success", "Logged in successfully"); // Show success message
    } else {
      Get.snackbar("Error", "Invalid username or password"); // Show error message
    }
  }

  // Method to log out the user
  void logout() {
    isLoggedIn.value = false; // Set login status to false
    Get.snackbar("Success", "Logged out successfully"); // Show logout message
  }
}
