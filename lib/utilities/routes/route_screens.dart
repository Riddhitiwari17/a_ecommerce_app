import 'package:e_commerce_test/screens/product_screen/product_screen.dart';
import 'package:e_commerce_test/utilities/routes/route_constants.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../screens/view_bag_screen/view_bag_screen.dart';

class RouteScreens {
  static final routes = [
    ///Login Screen
    GetPage(
        name: RouteConstants.productScreen, page: () => ProductScreen()),
    GetPage(
        name: RouteConstants.viewBagScreen, page: () => ViewBagScreen()),
  ];
}
