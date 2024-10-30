import 'package:e_commerce_test/utilities/routes/route_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfileController extends GetxController {
  var userData = {}.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId != null) {
      final url = Uri.parse('https://fakestoreapi.com/users/$userId');

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          userData.value = json.decode(response.body);
        } else {
          Get.snackbar('Error', 'Failed to load profile data');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred while fetching profile data');
      }
    } else {
      Get.snackbar('Error', 'User ID not found');
    }

    isLoading.value = false;
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(RouteConstants.loginScreen);
  }
}
