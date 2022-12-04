
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<UserController>(builder: (infoUser){
      var nameController=TextEditingController(text: infoUser.user.name);
      var phoneController=TextEditingController(text: infoUser.user.phone);
      var emailController=TextEditingController(text: infoUser.user.email);
      var addressController=TextEditingController(text: infoUser.address);
      Future<bool> _editProfile() async{
        String name=nameController.text.trim();
        String email=emailController.text.trim();
        String address=addressController.text.trim();
        String phoneNumber=phoneController.text.trim();
        if(name.isEmpty){
          showCustomSnackBar("Vui lòng nhập tên", title: "Tên");
        }else if(email.isEmpty){
          showCustomSnackBar("Vui lòng nhập email", title: "Email");
        }else if(address.isEmpty){
          showCustomSnackBar("Vui lòng nhập địa chỉ", title: "Địa chỉ");
        }else if(phoneNumber.isEmpty){
          showCustomSnackBar("Vui lòng nhập số điện thoại", title: "Số điện thoại");
        }else{
          var data={
            'name':name,
            'email':email,
            'phoneNumber':phoneNumber,
          };
          print(address);
          var addressUser={
            "information": "From Foody",
            "address": address,
            "addressType": "Nhà ở",
            "lat": 0,
            "lng": 0
          };
          bool check=await Get.find<UserController>().editProfile(data,addressUser);
          return check;
        }
        return false;

      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: const Center(child: Text("Chỉnh sửa cá nhân")),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor:Colors.white,
                    radius: 90,
                    backgroundImage: AssetImage(
                        "assets/images/logo.png"
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20),),
              AppTextField(textController: nameController, hintText: "Tên", icon: Icons.person),
              SizedBox(height: ScreenUtil().setHeight(20),),
              AppTextField(textController: phoneController, hintText: "Số điện thoại", icon: Icons.phone),
              SizedBox(height:  ScreenUtil().setHeight(20),),
              AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
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
                          Navigator.pop(context);
                          // Get.toNamed(RouteHelper.profile);
                        }else{
                          showCustomSnackBar("Cập nhật thất bại", title: "Thử lại");
                        }
                      },
                      child: BigText(
                        text: "Cập nhật",
                        size: ScreenUtil().setSp(15),
                        color: Colors.white,
                      ),
                    )
                ),

              ),
            ],
          ),
        ) ,
      );
    });

  }
}
