
import 'package:cdcn/controllers/payment_controller.dart';
import 'package:cdcn/utils/colors.dart';
import 'package:cdcn/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.mainColor,
        title: const Center(child: Text("Phiếu giảm giá")),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<PaymentController>(builder: (voucher){
          return   voucher.isLoaded? ListView.builder( padding:
          EdgeInsets.only(top: ScreenUtil().setHeight(5)),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: voucher.listVoucher.isEmpty?0:voucher.listVoucher.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    final amountDiscount=await Get.find<PaymentController>().checkVoucher(voucher.listVoucher[index]);
                    if(amountDiscount>=0){
                   Navigator.pop(context);
                    }
                  },
                  child: Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmallText(text: voucher.listVoucher[index].name,fontWeight: "bold",color: Colors.black ,),
                            SmallText(text: voucher.listVoucher[index].description),
                          ],
                        ),
                        SmallText(text: "Chọn", color: AppColors.mainColor,fontWeight: "bold",size: ScreenUtil().setSp(10),)
                      ],
                    ),
                  ),
                );
              }):Center(
                child: CircularProgressIndicator(
          color: AppColors.mainColor,
          ),
              );
        })

      )
    );
  }
}
