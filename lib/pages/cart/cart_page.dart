import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {

   CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: ScreenUtil().setHeight(30),
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
                    iconColor: Colors.black54,
                    icon: Icons.arrow_back,
                    size: ScreenUtil().setHeight(40),
                    iconSize:ScreenUtil().setHeight(25) ,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                SizedBox(width: ScreenUtil().setWidth(120),),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.homepage);
                  },
                  child: AppIcon(
                    iconColor: Colors.black54,
                    icon: Icons.home_outlined,
                    size: ScreenUtil().setHeight(40),
                    iconSize:ScreenUtil().setHeight(25) ,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                AppIcon(
                  iconColor: Colors.black54,
                  icon: Icons.shopping_cart,
                  size: ScreenUtil().setHeight(40),
                  iconSize:ScreenUtil().setHeight(25) ,
                  backgroundColor: AppColors.mainColor,
                ),

              ],
            ),
          ),
          Positioned(
            top:ScreenUtil().setHeight(50),
              left: ScreenUtil().setWidth(10),
              right: ScreenUtil().setWidth(10),
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top:ScreenUtil().setHeight(20)),
                child:MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    var _cartItems=cartController.getItems;
                    return cartController.getItems.isEmpty?Container():ListView.builder (
                        itemCount: cartController.getItems.isEmpty?1:cartController.getItems.length,
                        itemBuilder: (_,index){
                          Get.find<CartController>().getTotalMoneyItems(cartController.getItems[index].foodId);
                          return Container(
                           // height: ScreenUtil().setHeight(100),
                            width: double.maxFinite,
                            margin: EdgeInsets.only(top:ScreenUtil().setHeight(10)),
                            child: Row(
                              children: [
                                Container(
                                 // height: ScreenUtil().setWidth(100),
                                  width: ScreenUtil().setWidth(100),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.network(
                                      fit:BoxFit.cover,
                                      cartController.getItems[index].imageUrl!,
                                      // foodsStore.foodOfStoreList[index].imageUrl!,
                                      errorBuilder:
                                          (BuildContext context, Object exception, StackTrace? stackTrace) {

                                        return const Text("...");
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: ScreenUtil().setWidth(5),),
                                Expanded(child: Container(
                                  //height: ScreenUtil().setHeight(100),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: cartController.getItems[index].foodName!),
                                      cartController.getTopping(cartController.getItems[index].foodId!)==""
                                          ? Container(): SmallText(text: cartController.getTopping(cartController.getItems[index].foodId!)!,maxLines: 5, color: AppColors.paraColor,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text:cartController.getTotalMoneyItems(cartController.getItems[index].foodId!).toVND(unit:'đ') , color: Colors.redAccent,),
                                          Row(
                                            children: [
                                              Container(
                                                margin:EdgeInsets.only(right:ScreenUtil().setHeight(20)),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(ScreenUtil().radius(20)),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(_cartItems[index].food!, -1, _cartItems[index].listFoodTopping,_cartItems[index].storeID.toString());
                                                        print("tru");
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: AppColors.signColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: ScreenUtil().setWidth(10),
                                                    ),
                                                    BigText(text: cartController.getItems[index].quantity.toString()!),
                                                    SizedBox(
                                                      width: ScreenUtil().setWidth(10),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(_cartItems[index].food!, 1, _cartItems[index].listFoodTopping,_cartItems[index].storeID.toString());
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color: AppColors.signColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap:(){
                                                  cartController.addItem(_cartItems[index].food!, -_cartItems[index].quantity!, _cartItems[index].listFoodTopping,_cartItems[index].storeID.toString());
                          },
                                                child: AppIcon(
                                                  iconColor: Colors.grey,
                                                  icon: Icons.delete,
                                                  size: ScreenUtil().setHeight(40),
                                                  iconSize:ScreenUtil().setHeight(25) ,
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )

                                        ],
                                      )
                                    ],

                                  ),
                                ))
                              ],
                            ),
                          );

                        });
                  })
                ),

          ))
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cart) {
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
                        
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        BigText(text:cart.totalAmount.toString().toVND(unit: "đ"),color: Colors.redAccent,),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
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
                    child:  GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.paymentPage);
                        },
                        child: BigText(
                          text: "Thanh toán",
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        )
    );
  }
}
