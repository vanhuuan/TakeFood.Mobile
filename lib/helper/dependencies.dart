import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/foodDetail_controller.dart';
import '../controllers/foodOfStore_controller.dart';
import '../controllers/recommended_storenear_controller.dart';
import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/foodDetail_repo.dart';
import '../data/repository/foodOfStore_repo.dart';
import '../data/repository/recommended_storenear_repo.dart';
import '../data/repository/user_repo.dart';
Future<void> init() async {
  final sharePreferences=await SharedPreferences.getInstance();
  //await sharePreferences.remove("Cart-list");
  Get.lazyPut(()=>sharePreferences);
  //api client
  Get.lazyPut(() =>ApiClient(appBaseUrl: "https://takefoodauthentication.azurewebsites.net/"));
  //repo
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => UserController(popularProductRepo: Get.find()));
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

}