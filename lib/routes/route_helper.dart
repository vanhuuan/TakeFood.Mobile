
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/auth/sign_in_page.dart';
import '../pages/home/home_page.dart';

class RouteHelper{
  static const String initial="/";
  static const String homepage="/home_page";
  static const String storeDetail="/store_detail";

  static String getInitial()=>'$initial';
  static String getHomePage()=>'$homepage';
  static String getStoreDetail(String storeId)=>'$storeDetail?storeId=$storeId';
  static List<GetPage> routes=[
    GetPage(name: initial, page: ()=>SignInPage()),
    GetPage(name: homepage, page:(){
      return HomePage();
  } , transition: Transition.rightToLeftWithFade
    ),

  ];
}