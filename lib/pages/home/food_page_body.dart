
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/foodOfStore_controller.dart';
import '../../controllers/recommended_storenear_controller.dart';
import '../../models/store_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';


class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = ScreenUtil().setHeight(280);
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          //slider section
          GetBuilder<RecommendedStoreNearController>(builder: (storeNear){
            return  storeNear.isLoaded? Container(
              height: ScreenUtil().setHeight(280),
              child: PageView.builder(
                  controller: pageController,
                  // itemCount: storeNear.storeNearList.length,
                  itemCount: 5,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position,storeNear.storeNearList[position]);
                  }),
            ):CircularProgressIndicator(
              color: AppColors.mainColor,
            );
          }),

          //dots
          GetBuilder<RecommendedStoreNearController>(builder: (storeNear){
            return  DotsIndicator(
              //  dotsCount: storeNear.storeNearList.isEmpty?1:storeNear.storeNearList.length,
                dotsCount: 5,
                position: _currPageValue,
                decorator: DotsDecorator(
                  activeColor: AppColors.mainColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                )
            );
          }),

          //Popular Text
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "Phổ biến",
                  color: AppColors.mainColor,
                ),
              ],
            ),
          ),
          //list of  food and images
          GetBuilder<RecommendedStoreNearController>(builder: (storeNear){
            return storeNear.isLoaded? ListView.builder(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: storeNear.storeNearList.isEmpty?1:storeNear.storeNearList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      bool check=await Get.find<FoodOfStoreController>().getAllFoodOfStore(storeNear.storeNearList[index].storeId!, "16.073877", "108.149892");
                      if(check){
                        Get.toNamed(RouteHelper.getStoreDetail(storeNear.storeNearList[index].storeId!));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(10)),
                      child: Row(
                        children: [
                          //image section
                          Container(
                            width:ScreenUtil().setWidth(80),
                            height: ScreenUtil().setHeight(90),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(15)),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(storeNear.storeNearList[index].image!))),
                          ),
                          //text container
                          Expanded(
                            child: Container(
                              height: ScreenUtil().setWidth(98),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(ScreenUtil().radius(15)),
                                  bottomRight: Radius.circular(ScreenUtil().radius(15)),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: ScreenUtil().setWidth(10),right:  ScreenUtil().setWidth(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: storeNear.storeNearList[index].name,size:  ScreenUtil().setSp(10),),
                                    SizedBox(height:  ScreenUtil().setHeight(5),),
                                    SmallText(text: (storeNear.storeNearList[index].address.split(","))[0]!,maxLines: 1,size: ScreenUtil().setSp(8),),
                                    SizedBox(height: ScreenUtil().setHeight(5),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // IconAndTextWidget(
                                        //     icon: Icons.food_bank_outlined,
                                        //     text: "Quán NSL",
                                        //     iconColor: AppColors.iconColor1),
                                        IconAndTextWidget(
                                            icon: Icons.location_on,
                                            text: "${(storeNear.storeNearList[index].distance.toString().substring(0,3))!}km",
                                            iconColor: AppColors.iconColor1),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }):CircularProgressIndicator(
              color: AppColors.mainColor,
            );
          })

        ]
    );
  }

  Widget _buildPageItem(int index,Store storeNear) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () async {
          bool check=await Get.find<FoodOfStoreController>().getAllFoodOfStore(storeNear.storeId!, "16.073877", "108.149892");
          if(check){
            Get.toNamed(RouteHelper.getStoreDetail(storeNear.storeId!));
          }
        },
        child: Stack(
          children: [
            Container(
              height: ScreenUtil().setHeight(230),
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(storeNear.image!))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScreenUtil().setHeight(105),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(25),
                    right: ScreenUtil().setWidth(25),
                    bottom:ScreenUtil().setHeight(10)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(25)),
                    color: Colors.white,
                    boxShadow: [
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
                  child: AppColumn(text: storeNear.name.toString(),star:storeNear.star!,address: storeNear.address!,distance: storeNear.distance! ,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
