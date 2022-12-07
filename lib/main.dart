import 'package:cdcn/pages/auth/sign_up_page.dart';
import 'package:cdcn/routes/route_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/cart_controller.dart';
import 'controllers/recommended_storenear_controller.dart';
import 'controllers/user_controller.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token= prefs.getString("token");
  if(token!=null){
    await Get.find<UserController>().getUser();
    };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var data={
      "lat": 16.073877,
      "lng": 108.149892,
      "radiusIn": 0,
      "radiusOut": 1
    };


    Get.find<RecommendedStoreNearController>().getRecommendedStoreNearList(data);
    Get.find<CartController>().getCartData();
    return ScreenUtilInit(
      designSize: const Size(410, 730),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // home: SplashSreeen(),
          initialRoute: RouteHelper.Splashpage,
          //initialRoute: token==null? RouteHelper.getInitial():RouteHelper.getHomePage(),
          getPages: RouteHelper.routes,
        );
      },
      // child: const HomePage(title: 'First Method'),
    );
  }
}

