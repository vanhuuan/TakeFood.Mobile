
import 'package:cdcn/pages/auth/sign_in_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    Future<bool> _register() async{
      var data={
        'name':nameController.text,
        'email':emailController.text,
        'password':passwordController.text,
        'phoneNumber':phoneController.text,
      };
      var check=await Get.find<UserController>().SignUp(data, "SignUp");
      return check;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: ScreenUtil().setHeight(50),),
            Container(
              height: ScreenUtil().setHeight(150),
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
            AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
            SizedBox(height:  ScreenUtil().setHeight(20),),
            AppTextField(textController: phoneController, hintText: "Số điện thoại", icon: Icons.phone),
            SizedBox(height:  ScreenUtil().setHeight(20),),
            AppTextField(textController: passwordController, hintText: "Mật khẩu", icon: Icons.password_sharp,obscureText: true,),
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
                      var signup=await _register();
                      if(signup==true){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );
                      }else{
                        emailController.text="";
                        nameController.text="";
                        phoneController.text="";
                        passwordController.text="";
                        Text("SAI rooif");
                      }
                    },
                    child: BigText(
                      text: "ĐĂNG KÝ",
                      size: ScreenUtil().setSp(15),
                      color: Colors.white,
                    ),
                  )
              ),

            ),
            SizedBox(height: ScreenUtil().setHeight(20),),
            RichText(
                text: TextSpan(
                    text: "Đã có tài khoản? ",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: ScreenUtil().setSp(18)
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignInPage()),
                        text: " Đăng nhập",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainBlackColor,
                            fontSize: ScreenUtil().setSp(22)
                        ),)
                    ]
                )),
          ],
        ),
      ) ,
    );
  }
}
