import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
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

}