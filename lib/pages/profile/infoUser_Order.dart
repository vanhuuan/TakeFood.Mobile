
import 'package:cdcn/base/show_custom_snackbar.dart';
import 'package:cdcn/controllers/payment_controller.dart';
import 'package:cdcn/utils/colors.dart';
import 'package:cdcn/widgets/app_text_field.dart';
import 'package:cdcn/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class InfoUserOrder extends StatefulWidget {
  const InfoUserOrder({Key? key}) : super(key: key);

  @override
  State<InfoUserOrder> createState() => _InfoUserOrderState();
}

class _InfoUserOrderState extends State<InfoUserOrder> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (infoUser){
      var nameController=TextEditingController(text: infoUser.user.name);
      var phoneController=TextEditingController(text: infoUser.user.phone);
      var addressController=TextEditingController(text: infoUser.addressUser);
      var data;
      Future<bool> _editProfile() async{
        String name=nameController.text.trim();
        String address=addressController.text.trim();
        String phoneNumber=phoneController.text.trim();
        if(name.isEmpty){
          showCustomSnackBar("Vui lòng nhập tên", title: "Tên");
        }else if(address.isEmpty){
          showCustomSnackBar("Vui lòng nhập địa chỉ", title: "Địa chỉ");
        }else if(phoneNumber.isEmpty){
          showCustomSnackBar("Vui lòng nhập số điện thoại", title: "Số điện thoại");
        }else{
           data={
            'name':name,
            'phoneNumber':phoneNumber,
            "address":address
          };
          return true;
        }
        return false;

      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Center(child: Text("Thay đổi thông tin",)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(20),),
              AppTextField(textController: nameController, hintText: "Tên", icon: Icons.person),
              SizedBox(height: ScreenUtil().setHeight(20),),
              AppTextField(textController: phoneController, hintText: "Số điện thoại", icon: Icons.phone),
              SizedBox(height:  ScreenUtil().setHeight(20),),
              AppTextField(textController: addressController, hintText: "Địa chỉ", icon: Icons.location_on_sharp,),
              SizedBox(height:  ScreenUtil().setHeight(40),),
              Container(
                width:  ScreenUtil().setWidth(250),
                height:  ScreenUtil().setHeight(60),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( ScreenUtil().radius(30)),
                    color: AppColors.mainColor
                ),

                child: Center(
                    child:GestureDetector(
                      onTap: () async {
                        var edit=await _editProfile();
                        if(edit){
                          Navigator.pop(context,data);
                          // Get.toNamed(RouteHelper.profile);
                        }else{
                          showCustomSnackBar("Cập nhật thất bại", title: "Thử lại");
                        }
                      },
                      child: BigText(
                        text: "Hoàn thành",
                        size: ScreenUtil().setSp(15),
                        color: Colors.white,
                      ),
                    )
                ),

              ),
            ],
          ),
        ),
      );
    });
  }
}
