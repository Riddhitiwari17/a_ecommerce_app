import 'package:e_commerce_test/screens/product_screen/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../view_bag_screen/view_cart_model.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs; // Observable list for reactive updates
  var categoryList = <String>[].obs; // Observable list for categories
  var selectedCategory = ''.obs; // Currently selected category
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  var sortOrder = 'asc'.obs;
  var cartItems = <CartItem>[].obs; // Correctly define cartItems as RxList<CartItem>

  @override
  void onInit() {
    super.onInit();
    getCategories(); // Fetch categories on initialization
    getProductsFromApi(); // Fetch products on initialization
  }

  Future<void> getCategories() async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        categoryList.value = List<String>.from(jsonResponse);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getProductsFromApi() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        productList.value = jsonResponse.map((product) => Product.fromJson(product)).toList();
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
    final existingItem = cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      existingItem.quantity++;
      cartItems.refresh(); // Trigger update for cartItems if quantity changes
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }
  }

  List<Product> get filteredProducts {
    var filtered = productList.where((product) {
      final matchesSearchQuery = product.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesCategory = selectedCategory.value.isEmpty || product.category == selectedCategory.value;
      return matchesSearchQuery && matchesCategory;
    }).toList();

    // Sort based on sort order
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
}
