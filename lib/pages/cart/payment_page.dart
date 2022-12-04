import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/payment_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    var note = TextEditingController();
    int total = 0;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Center(child: Text("Thanh toán")),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              GetBuilder<PaymentController>(builder: (infoUser) {
                return Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(4),
                      left: ScreenUtil().setWidth(20),
                      right: ScreenUtil().setWidth(10)),
                  height: ScreenUtil().setHeight(150),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppColors.borderBottom, width: 5.0))),
                  width: double.maxFinite,
                  //color: AppColors.paraColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText(
                            text: "Địa chỉ",
                            color: const Color(0xFFFF8357),
                            fontWeight: "bold",
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: GestureDetector(
                              onTap: () async {
                                // final result=await Get.toNamed(RouteHelper.infoUserOrder);
                                // infoUser.editInfoUser(result);
                              },
                              child: SmallText(
                                  text: "Thay đổi",
                                  color: AppColors.mainColor,
                                  fontWeight: "bold"),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(3),
                      ),
                      SmallText(
                          text:
                          infoUser.addressUser,
                          maxLines: 2,
                          color: AppColors.mainBlackColor),
                      SizedBox(
                        height: ScreenUtil().setWidth(3),
                      ),
                      SmallText(
                          text: "SĐT",
                          color: Color(0xFFFF8357),
                          fontWeight: "bold"),
                      SmallText(
                        text: infoUser.phoneNumberUser,
                        color: AppColors.mainBlackColor,
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: ScreenUtil().setWidth(4),
              ),
              Container(
                // color: AppColors.paraColor,
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(4),
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(10)),
                height: ScreenUtil().setHeight(200),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(
                        text: "Đơn hàng của bạn",
                        color: Color(0xFFFF8357),
                        fontWeight: "bold"),
                    Expanded(child: SingleChildScrollView(
                        child: GetBuilder<CartController>(builder: (cartStorage) {
                      total = cartStorage.totalAmount;
                      return cartStorage.getItems.isEmpty
                          ? Container()
                          : ListView.builder(
                              padding:
                                  EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartStorage.getItems.isEmpty
                                  ? 1
                                  : cartStorage.getItems.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  //height: ScreenUtil().setHeight(100),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: AppColors.borderBottom,
                                              width: 1.0))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              SmallText(
                                                text:
                                                "${cartStorage.getItems[index].quantity}x",
                                                color: Colors.black,
                                                fontWeight: "bold",
                                                size: ScreenUtil().setSp(8),
                                              ),
                                              SizedBox(
                                                width: ScreenUtil().setWidth(10),
                                              ),
                                              SmallText(
                                                text:
                                                cartStorage.getItems[index].foodName!,
                                                fontWeight: "bold",
                                                size: ScreenUtil().setSp(11),
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                          SmallText(
                                            text: cartStorage
                                                .getTotalMoneyItems(cartStorage
                                                .getItems[index].foodId!)
                                                .toString()
                                                .toVND(unit: "đ"),
                                            fontWeight: "bold",
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                  SizedBox(height: ScreenUtil().setHeight(5)),
                                  SmallText(
                                    text: cartStorage.getTopping(
                                        cartStorage.getItems[index]
                                            .foodId!)!,maxLines: 5,color: AppColors.paraColor,size: ScreenUtil().setSp(8),
                                            ),
                                    ],
                                  ),
                                );
                              });
                    }))),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(5),
              ),
              SizedBox(
                child: TextField(
                  controller: note,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Lời nhắn cho cửa hàng",
                    hintStyle: TextStyle(
                        color: Color(0xFFFF8357),
                        fontSize: ScreenUtil().setSp(10)),
                    prefixIcon: const Icon(
                      Icons.assessment_rounded,
                      color: Color(0xFFFF8357),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 1,
                      color: AppColors.borderBottom,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 1,
                      color: AppColors.borderBottom,
                    )),
                  ),
                  style: TextStyle(fontSize: ScreenUtil().setSp(10)),
                ),
              ),
              GetBuilder<CartController>(builder: (totalItem) {
                return Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(4),
                      left: ScreenUtil().setWidth(20),
                      right: ScreenUtil().setWidth(10)),
                  height: ScreenUtil().setHeight(80),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppColors.borderBottom, width: 2.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText(
                              text: "Tạm tính:",
                              color: Colors.black,
                              fontWeight: "bold"),
                          SmallText(
                              text: totalItem.totalAmount.toVND(unit: "đ"),
                              color: Colors.black,
                              fontWeight: "bold"),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setWidth(5),
                      ),
                      GestureDetector(
                        onTap: ()  {
                            Get.find<PaymentController>().getVoucher(totalItem.getItems[0].storeID!);
                            Get.toNamed(RouteHelper.voucherPage);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                AppIcon(
                                    icon: Icons.discount_rounded,
                                    iconColor: Color(0xFFFF8357),
                                    size: ScreenUtil().setWidth(20)),
                                SmallText(
                                    text: "Voucher:",
                                    color: Colors.black,
                                    fontWeight: "bold"),
                              ],
                            ),
                            GetBuilder<PaymentController>(builder: (discount) {
                              return discount.amountDiscount == 0
                                  ? SmallText(text: "Chọn tại đây >>>")
                                  : SmallText(
                                      text:
                                          "-${discount.amountDiscount.toString().toVND(unit: "đ")}",
                                      color: Colors.black,
                                    );
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
              Container(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(4),
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(10)),
                height: ScreenUtil().setHeight(70),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppColors.borderBottom, width: 2.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SmallText(
                        text: "Phương thức thanh toán:",
                        fontWeight: "bold",
                        color: Colors.black),
                    SmallText(text: "Tiền mặt", color: Colors.black),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: GetBuilder<PaymentController>(
          builder: (payment) {
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
                        BigText(
                          text: payment.getTotal().toString().toVND(unit: "đ"),
                          color: Colors.redAccent,
                        ),
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
                    child: GestureDetector(
                      onTap: () async {
                          payment.confirmOrder(note.text);
                          Get.toNamed(RouteHelper.myOrderPage);
                      },
                      child: BigText(
                        text: "Đặt hàng",
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
