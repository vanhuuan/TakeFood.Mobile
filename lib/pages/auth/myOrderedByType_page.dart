

import 'package:cdcn/controllers/myOrdered_controller.dart';
import 'package:cdcn/models/myOrdered_model.dart';
import 'package:cdcn/routes/route_helper.dart';
import 'package:cdcn/utils/colors.dart';
import 'package:cdcn/widgets/app_icon.dart';
import 'package:cdcn/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyOrderedByType extends StatelessWidget {
  const MyOrderedByType({Key? key, required this.data, }) : super(key: key);
  final List<MyOrdered>? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:  data!.isNotEmpty?ListView.builder(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.find<MyOrderController>().getDetailOrdered(data![index].orderId);
                      Get.find<MyOrderController>().getReviewByorderId(data![index].orderId);
                      Get.toNamed(RouteHelper.detailOrdered);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(4),
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(10)),
                      height: ScreenUtil().setHeight(120),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: AppColors.borderBottom, width: 2.0)),
                      ),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              AppIcon(
                                icon: Icons.check,
                                size: ScreenUtil().setHeight(20),
                                backgroundColor: Colors.grey,
                                iconColor: Colors.white,
                                iconSize: ScreenUtil().setHeight(15),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(8),
                              ),
                              SmallText(
                                text:
                                data![index].state!,
                                color: AppColors.mainBlackColor,
                                size: ScreenUtil().setSp(8),
                              ),
                            ],
                          ),
                          SmallText(
                            text:
                            data![index].storeName!,
                            color: AppColors.mainBlackColor,
                            size: ScreenUtil().setSp(12),
                            maxLines: 1,
                          ),
                          SmallText(
                            text:
                                "${data![index].foodQuantity}món",
                            fontWeight: "bold",
                            size: ScreenUtil().setSp(8),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(
                                text: data![index].total
                                    .toString(),
                                color: AppColors.mainBlackColor,
                                fontWeight: "bold",
                                size: ScreenUtil().setSp(10),
                              ),
                              SmallText(
                                text: "Xem chi tiết",
                                color: AppColors.mainColor,
                                fontWeight: "bold",
                                size: ScreenUtil().setSp(8),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }):Center(child: Text("Trống"))

      ),
    );
  }
}
