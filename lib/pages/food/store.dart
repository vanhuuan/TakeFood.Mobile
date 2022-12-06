import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/foodDetail_controller.dart';
import '../../controllers/foodOfStore_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

import '../../widgets/small_text.dart';

class StorePage extends StatelessWidget {
  String storeId;
  StorePage({Key? key,required this.storeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Column(children: [
        GetBuilder<FoodOfStoreController>(builder: (foodStore){
          return  Container(
            height: ScreenUtil().setHeight(320),
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.maxFinite,
                      height: ScreenUtil().setHeight(260),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(foodStore.foodsStore.imgUrl!))),
                    )),
                Positioned(
                    top: ScreenUtil().setHeight(20),
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back,
                            size: ScreenUtil().setHeight(25),
                          ),
                        ),
                        Row(
                          children: [
                            AppIcon(
                                icon: Icons.favorite, size: ScreenUtil().setHeight(25)),
                            AppIcon(
                                icon: Icons.search, size: ScreenUtil().setHeight(25)),
                          ],
                        )


                      ],
                    )),
                Positioned(
                  top: ScreenUtil().setHeight(200),
                  left: ScreenUtil().setWidth(10),
                  right: ScreenUtil().setWidth(10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: ScreenUtil().setHeight(115),
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(25),
                          right: ScreenUtil().setWidth(25),
                          bottom: ScreenUtil().setHeight(10)),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(15)),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xFFe8e8e8),
                                blurRadius: 5.0,
                                offset: Offset(0, 5)),
                            BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                            BoxShadow(color: Colors.white, offset: Offset(5, 0))
                          ]),
                      child: Container(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(10),
                              left: ScreenUtil().setWidth(10),
                              right: ScreenUtil().setWidth(10)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BigText(
                                  text:  foodStore.foodsStore.storeName!,
                                  size: ScreenUtil().setSp(13),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                        icon: Icons.location_on,
                                        text: "${(foodStore.foodsStore.distance.toString().substring(0,3))!}km",
                                        iconColor: AppColors.iconColor1),
                                    IconAndTextWidget(
                                        icon: Icons.phone,
                                        text: foodStore.foodsStore.phoneNumber!,
                                        iconColor: AppColors.iconColor1),

                                  ],
                                ),
                                IconAndTextWidget(
                                    icon: Icons.home_outlined,
                                    text: foodStore.foodsStore.address.split(",")[0]!,
                                    iconColor: AppColors.iconColor1),


                              ])),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        GetBuilder<FoodOfStoreController>(builder: (foodsStore){
          return Container(
            margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(10),
              right: ScreenUtil().setWidth(10),
            ),
            height: ScreenUtil().setWidth(60),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.borderBottom, width: 2.0),
                  top: BorderSide(color: AppColors.borderBottom, width: 2.0)),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(10),
                  right: ScreenUtil().setWidth(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconAndTextWidget(
                      icon: Icons.star,
                      text: "${foodsStore.foodsStore.star.toString()!}(${foodsStore.foodsStore.numOfReview.toString()!})",
                      iconColor: const Color(0xFFFF8357)),
                  IconAndTextWidget(
                      icon: Icons.shopping_bag,
                      text: "${foodsStore.foodsStore.numOfOrder.toString()!} đã bán",
                      iconColor: const Color(0xFFFF8357)),
                  GestureDetector(
                    onTap: (){
                      foodsStore.getAllComment(foodsStore.foodsStore.storeId);
                      Get.toNamed(RouteHelper.reviewPage);
                    },
                    child: SmallText(
                      text: "Xem đánh giá",
                      color: const Color(0xFF89D5C9),
                      size: ScreenUtil().setSp(8),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
        GetBuilder<FoodOfStoreController>(builder: (foodsStore){
          return  Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: foodsStore.foodOfStoreList.isEmpty?0:foodsStore.foodOfStoreList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                           await Get.find<FoodDetailController>().getFoodDetailById(foodsStore.foodOfStoreList[index].foodId);
                          // //print(foodsStore.foodOfStoreList[index].storeId.toString());
                          Get.toNamed(RouteHelper.getDetailFood(storeId));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(10),
                              right: ScreenUtil().setWidth(10),
                              bottom: ScreenUtil().setWidth(10)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.borderBottom, width: 2.0))),
                          child: Row(
                            children: [
                              //image section
                              //text container
                              Expanded(
                                child: Container(
                                  height: ScreenUtil().setWidth(98),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(ScreenUtil().radius(15)),
                                      bottomRight:
                                      Radius.circular(ScreenUtil().radius(15)),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(10),
                                        right: ScreenUtil().setWidth(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SmallText(
                                            text: foodsStore.foodOfStoreList[index].foodName!,
                                            size: ScreenUtil().setSp(10),
                                            color: AppColors.mainBlackColor),
                                        SizedBox(height: ScreenUtil().setHeight(20)),
                                        BigText(
                                          text: foodsStore.foodOfStoreList[index].price.toString().toVND(unit: 'đ'),
                                          color: AppColors.mainBlackColor,
                                          size: ScreenUtil().setSp(10),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setWidth(110),
                                width: ScreenUtil().setWidth(110),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.network(
                                    foodsStore.foodOfStoreList[index].imageUrl!,
                                    errorBuilder:
                                        (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      // Appropriate logging or analytics, e.g.
                                      // myAnalytics.recordError(
                                      //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                                      //   exception,
                                      //   stackTrace,
                                      // );
                                      return const Text("...");
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ));
        }),

      ]),

    );
  }
}
