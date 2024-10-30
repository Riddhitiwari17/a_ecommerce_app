import 'package:e_commerce_test/screens/product_screen/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../view_bag_screen/view_cart_model.dart';
import 'category_model.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;
  var categoryList = <Thought>[].obs;
  var selectedCategory = ''.obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  var sortOrder = 'asc'.obs;
  var cartItems = <CartItem>[].obs;
  RxBool isSelectedCategory = false.obs;
  var isCategoryContainerVisible = false.obs;

  Rx<TextEditingController> etSearchQuery = TextEditingController().obs;
  RxBool searchQueryTypeHasFocus = false.obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
    checkUserLoggedIn();
    getProductsFromApi();
  }

  void checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getInt('userId') != null;

    print("loginin ${isLoggedIn.value}");
  }

  Future<void> getCategories() async {
    try {
      final response = await http
          .get(Uri.parse('https://fakestoreapi.com/products/categories'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        categoryList.value =
            jsonResponse.map((category) => Thought.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e);
    }
  }

  void searchProduct() {
    if (searchQueryTypeHasFocus.value == true) {
      etSearchQuery.value.addListener(() async {
        if (etSearchQuery.value.text.isNotEmpty) {
          getSearchCategoryData();
        } else {
          categoryList.clear();
        }
      });
    }
  }

  Future<void> getSearchCategoryData() async {
    try {
      final response = await http
          .get(Uri.parse('https://fakestoreapi.com/products/categories'));

      etSearchQuery.value.clear();
      List jsonResponse = json.decode(response.body);
      List<Thought> list = jsonResponse
          .map<Thought>((element) => Thought.fromJson(element))
          .toList();

      if (list.isNotEmpty) {
        isSelectedCategory.value = true;
        categoryList.value = list;
      } else {
        isSelectedCategory.value = false;
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  Future<void> getProductsFromApi() async {
    try {
      isLoading.value = true;
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        productList.value =
            jsonResponse.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(Product product) {
    final existingItem =
        cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      existingItem.quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }
  }

  List<Product> get filteredProducts {
    var filtered = productList.where((product) {
      final matchesSearchQuery =
          product.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesCategory = selectedCategory.value.isEmpty ||
          product.category == selectedCategory.value;
      return matchesSearchQuery && matchesCategory;
    }).toList();
    if (sortOrder.value == 'asc') {
      filtered.sort((a, b) => (a.price ?? 0.0).compareTo(b.price ?? 0.0));
    } else {
      filtered.sort((a, b) => (b.price ?? 0.0).compareTo(a.price ?? 0.0));
    }
    return filtered;
  }

  void toggleSortOrder() {
    sortOrder.value = sortOrder.value == 'asc' ? 'desc' : 'asc';
  }

  void toggleCategoryContainer() {
    isCategoryContainerVisible.value = !isCategoryContainerVisible.value;
  }
}
