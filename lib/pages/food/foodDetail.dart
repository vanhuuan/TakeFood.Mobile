
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/foodDetail_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';

class FoodDetail extends StatefulWidget {
  String storeID;
  FoodDetail({Key? key,required this.storeID}) : super(key: key);

  @override
  State<FoodDetail> createState() => _FoodDetailState(storeID);
}

class _FoodDetailState extends State<FoodDetail> {
  final List _selectedIndexs=[];
  var storeId;
  _FoodDetailState(storeID){
    storeId=storeID;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<FoodDetailController>(builder: (foodDetail) {
          return Stack(
            children: [
              //background image
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: ScreenUtil().setHeight(240),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: Image.network(foodDetail.foodsDetail.urlImage,
                                errorBuilder:  (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return const Text("...");
                                },
                              ).image,
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  )),
              //icon widgets
              Positioned(
                  top: ScreenUtil().setHeight(20),
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: AppIcon(
                              iconColor: Colors.black54,
                              icon: Icons.arrow_back,
                              size: ScreenUtil().setHeight(40),
                              iconSize:ScreenUtil().setHeight(25) ,
                              backgroundColor: AppColors.mainColor,
                            )),
                        GetBuilder<FoodDetailController>(builder: (controller) {
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap:(){
                                  if(foodDetail.totalItems>=1){
                                    Get.toNamed(RouteHelper.getCartPage(storeId));
                                  }
                                },
                                child: AppIcon(
                                  iconColor: Colors.black54,
                                  icon: Icons.shopping_cart_outlined,
                                  size: ScreenUtil().setHeight(40),
                                  iconSize:ScreenUtil().setHeight(25) ,
                                  backgroundColor: AppColors.mainColor,),
                              ),
                              Get.find<FoodDetailController>().totalItems >= 1
                                  ? Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: Get.find<FoodDetailController>()
                                      .totalItems
                                      .toString(),
                                  size: ScreenUtil().setSp(5),
                                  color: Colors.red,
                                ),
                              )
                                  : Container()
                            ],
                          );
                        })
                      ],
                    ),
                  )),
              //introduction of food
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: ScreenUtil().setHeight(220),
                  child: Container(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(20),
                          top: ScreenUtil().setWidth(20)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight:
                              Radius.circular(ScreenUtil().radius(20)),
                              topLeft:
                              Radius.circular(ScreenUtil().radius(20))),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BigText(
                                  text: foodDetail.foodsDetail.name!,
                                  size: ScreenUtil().setSp(12),
                                  maxLines: 2,
                                ),
                                BigText(
                                  text: foodDetail.foodsDetail.price.toString(),
                                  size: ScreenUtil().setSp(12),
                                ),
                              ],
                            ),
                          ),
                          //AppColumn(text: "Bun mam Da Nang"),
                          SizedBox(
                            height: ScreenUtil().setHeight(10),
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                child: ExpandableTextWidget(
                                    text:foodDetail.foodsDetail.description!),
                              )),
                          Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    GetBuilder<FoodDetailController>(builder: (topping){
                                      return topping.toppingFood.isEmpty?Container():Container(
                                        //margin: EdgeInsets.only(left: Dimensions.height10),
                                        child: Row(
                                          children: [
                                            BigText(
                                              text: "Chọn topping",
                                              color: AppColors.mainBlackColor,
                                              size: ScreenUtil().setSp(12),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                    GetBuilder<FoodDetailController>(builder: (topping){
                                      return topping.toppingFood.isEmpty?Container():ListView.builder(
                                          padding: EdgeInsets.only(top:ScreenUtil().setHeight(5)),
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: topping.toppingFood.isEmpty?1:topping.toppingFood.length,
                                          itemBuilder: (context, index) {
                                            var _isSelected=_selectedIndexs.contains(index);

                                            return Container(
                                              margin: EdgeInsets.only(
                                                  top: ScreenUtil().setHeight(5)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child:GestureDetector(
                                                      onTap:()  {
                                                        setState((){
                                                          if(_isSelected){
                                                            _selectedIndexs.remove(index);
                                                            topping.addTopping(_isSelected, topping.toppingFood[index]);
                                                          }else{
                                                            _selectedIndexs.add(index);
                                                            topping.addTopping(_isSelected, topping.toppingFood[index]);
                                                          }
                                                        }
                                                        );
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(15),bottom: ScreenUtil().setHeight(8)),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: _isSelected?AppColors.mainColor:AppColors.borderBottom,
                                                                    width: 2.0
                                                                )
                                                            )
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                _isSelected?AppIcon(icon: Icons.check_outlined,iconColor: Colors.white70,size: ScreenUtil().setWidth(20),backgroundColor: AppColors.mainColor,):Container(),
                                                                BigText(text: topping.toppingFood[index].name!,size: ScreenUtil().setSp(10),),
                                                              ],
                                                            ),
                                                            BigText(text: topping.toppingFood[index].price.toString(),size: ScreenUtil().setSp(10),),
                                                          ],


                                                        ),

                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    })

                                  ],
                                ),
                              )),
                        ],
                      )))
            ],
          );
        }),
        bottomNavigationBar: GetBuilder<FoodDetailController>(
          builder: (foodDetail) {
            return Container(
              height: ScreenUtil().setHeight(80),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                  bottom: ScreenUtil().setHeight(6),
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(10)),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil().radius(20)),
                      topRight: Radius.circular(ScreenUtil().radius(20)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(7),
                        bottom: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(10),
                        right: ScreenUtil().setWidth(10)),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(20)),
                        color: Colors.white),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            foodDetail.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        BigText(text: foodDetail.quantity.toString()),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        GestureDetector(
                          onTap: () {
                            foodDetail.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(7),
                        bottom: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(10),
                        right: ScreenUtil().setWidth(10)),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(10)),
                        color: AppColors.mainColor),
                    child: GestureDetector(
                      onTap: () {
                        foodDetail.addItem(foodDetail.foodsDetail,storeId);
                        Get.toNamed(RouteHelper.cartPage);
                      },
                      child: BigText(
                        text: "Thêm  ${(foodDetail.foodsDetail.price*foodDetail.quantity+foodDetail.totalMoney).toString()}",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}