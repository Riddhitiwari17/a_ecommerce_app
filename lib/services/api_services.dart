import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/product_screen/product_model.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Fetch all products
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> productList = jsonDecode(response.body);
      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Add product to cart
  Future<void> addToCart(int productId, int quantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/cart'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'productId': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add product to cart');
    }
  }

  // Get items in the cart
  Future<List<Product>> fetchCartItems() async {
    final response = await http.get(Uri.parse('$baseUrl/cart'));

    if (response.statusCode == 200) {
      List<dynamic> cartItems = jsonDecode(response.body);
      return cartItems.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cart items');
    }
  }

  // Update item quantity in the cart
  Future<void> updateCartItem(int productId, int quantity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/cart/$productId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'quantity': quantity}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart item');
    }
  }

  // Remove an item from the cart
  Future<void> removeFromCart(int productId) async {
    final response = await http.delete(Uri.parse('$baseUrl/cart/$productId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to remove item from cart');
    }
  }

  // Process guest checkout
  Future<void> processGuestCheckout(Map<String, String> checkoutData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/checkout'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(checkoutData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to process checkout');
    }
  }
}
