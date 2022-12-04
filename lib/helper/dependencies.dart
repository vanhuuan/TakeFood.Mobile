import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../controllers/foodDetail_controller.dart';
import '../controllers/foodOfStore_controller.dart';
import '../controllers/myOrdered_controller.dart';
import '../controllers/payment_controller.dart';
import '../controllers/recommended_storenear_controller.dart';
import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/foodDetail_repo.dart';
import '../data/repository/foodOfStore_repo.dart';
import '../data/repository/myOrdered_repo.dart';
import '../data/repository/payment_repo.dart';
import '../data/repository/recommended_storenear_repo.dart';
import '../data/repository/user_repo.dart';
Future<void> init() async {
  final sharePreferences=await SharedPreferences.getInstance();
  //await sharePreferences.remove("token");
  Get.lazyPut(()=>sharePreferences);
  //api client
  Get.lazyPut(() =>ApiClient(appBaseUrl: "https://takefoodmobile.azurewebsites.net/"));
  //repo
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() {
    return UserController(userRepo: Get.find());
  },
      fenix: true);
  Get.lazyPut(() => FoodOfStoreRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => FoodOfStoreController(foodOfStoreRepo: Get.find()));
  Get.lazyPut(() => RecommendedStoreNearRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => RecommendedStoreNearController(recommendedStoreNearRepo: Get.find()));
  Get.lazyPut(() => FoodDetailRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() {
    return FoodDetailController(foodDetailRepo: Get.find(),sharedPreferences: Get.find());
  },
      fenix: true);
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  //controllers
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => PaymentRepo(apiClient: Get.find(),sharedPreferences: Get.find(),cart: Get.find()));
  Get.lazyPut(() {
    return PaymentController(paymentRepo: Get.find(),cartController: Get.find());
  },
      fenix: true);
  Get.lazyPut(() {
    return MyOrderController(myOrderedRepo: Get.find(),sharedPreferences: Get.find());
  },
      fenix: true);

  Get.lazyPut(() => MyOrderedRepo(apiClient: Get.find()));
}