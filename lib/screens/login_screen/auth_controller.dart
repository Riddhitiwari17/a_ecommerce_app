import 'package:e_commerce_test/utilities/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  var isLoggedIn = false.obs;

  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getInt('userId') != null;
  }

  Future<void> login() async {
    isLoading.value = true;

    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter both username and password');
      isLoading.value = false;
      return;
    }

    final url = Uri.parse('https://fakestoreapi.com/users');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> users = json.decode(response.body);
        final matchingUser = users.firstWhere(
          (user) =>
              user['username'] == username && user['password'] == password,
          orElse: () => null,
        );

        if (matchingUser != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', matchingUser['username']);
          await prefs.setInt('userId', matchingUser['id']);
          await prefs.setBool('isLoggedIn', true);

          print(matchingUser['id'].toString());

          Get.snackbar('Success', 'Login successful!');
          Get.offNamed(RouteConstants.productScreen);
        } else {
          Get.snackbar('Error', 'Invalid username or password');
        }
      } else {
        Get.snackbar('Error', 'Failed to connect to server');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while logging in');
    } finally {
      isLoading.value = false;
    }
  }
}
