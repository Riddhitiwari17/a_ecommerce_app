import 'package:e_commerce_test/screens/view_bag_screen/view_cart_model.dart';
import 'package:get/get.dart';

class ViewBagController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    cartItems.addAll(Get.arguments ?? []);
  }

  void incrementQuantity(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.removeAt(index);
    }
    cartItems.refresh();
  }
}
