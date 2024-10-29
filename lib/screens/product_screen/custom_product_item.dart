import 'package:flutter/material.dart';

// Assuming ProductController is defined somewhere else in your code
import 'package:get/get.dart';
import 'product_controller.dart';

class CustomProductItem extends StatelessWidget {
  final dynamic product; // Replace 'dynamic' with your specific product type

  const CustomProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Center(
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                height: 200, // Adjust height as needed
                width: double.infinity, // Make image take full width
              ),
            ),
            SizedBox(height: 16),
            // Product title
            Text(
              product.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), // Bold and larger font size
            ),
            SizedBox(height: 8),
            // Highlighted price
            Text(
              '\$${product.price?.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 22, // Larger font size for price
              ),
            ),
            SizedBox(height: 16),
            // Add to cart button
            ElevatedButton.icon(
              onPressed: () {
                // Add the product to the cart
                ProductController controller = Get.find();
                controller.addToCart(product);
              },
              icon: Icon(Icons.add_shopping_cart),
              label: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40), // Make the button take full width
              ),
            ),
          ],
        ),
      ),
    );
  }
}
