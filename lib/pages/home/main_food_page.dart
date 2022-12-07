
import 'package:cdcn/controllers/recommended_storenear_controller.dart';
import 'package:cdcn/pages/home/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(35), bottom:ScreenUtil().setHeight(20)),
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(8), right:ScreenUtil().setWidth(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AppIcon(icon: Icons.location_on_sharp,iconColor: AppColors.mainColor, size: ScreenUtil().setHeight(40),backgroundColor: Colors.white,
                        iconSize:ScreenUtil().setHeight(25),),
                      BigText(
                        text: "TP.Đà Nẵng",
                        color: AppColors.mainColor,
                        size: ScreenUtil().setSp(12),
                      ),
                    ],
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async{
                        List storeList=Get.find<RecommendedStoreNearController>().storeNearList;
                        showSearch(context: context, delegate: SearchStore(allStore: storeList,storeSuggestion:storeList));
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(35),
                        height: ScreenUtil().setHeight(30),
                        child: Icon(Icons.search,
                            color: Colors.white, size: ScreenUtil().setHeight(25)),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(10)),
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              )),
        ],
      ),
    );
  }
}
