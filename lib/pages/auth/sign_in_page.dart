import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import '../home/home_page.dart';
import 'sign_up_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController=TextEditingController();
    var emailController=TextEditingController();
     double screenHeight=Get.context!.height; //820
     double screenWidth=Get.context!.width;  //411
    print(screenHeight  ) ;
    print( screenWidth) ;
    Future<bool> _login() async {
      var data={
        'username':emailController.text,
        'password':passwordController.text,
      };
      var check=await Get.find<UserController>().SignIn(data, "SignIn");
      return check;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: ScreenUtil().setHeight(36.5),),
            Container(
              height: ScreenUtil().setHeight(182),
              child: Center(
                child: CircleAvatar(
                  backgroundColor:Colors.white,
                  radius: 90,
                  backgroundImage: AssetImage(
                      "assets/images/logo.png"
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Fooder xin chào",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(25),),
            AppTextField(textController: emailController, hintText: "Email", icon: Icons.phone,textInputType: TextInputType.emailAddress,),
            SizedBox(height: ScreenUtil().setHeight(20),),
            AppTextField(textController: passwordController, hintText: "Mật khẩu", icon: Icons.password_sharp,obscureText: true,),
            SizedBox(height: ScreenUtil().setHeight(50),),

            Container(
              width: ScreenUtil().setWidth(250),
              height: ScreenUtil().setHeight(70),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),
                  color: AppColors.mainColor
              ),
              child: Center(
                child:GestureDetector(
                  onTap: () async {
                    var signup=await _login();
                    if(signup==true){
                      Get.to(()=>HomePage());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    }else{
                      print("SAI");
                    }
                  },
                  child: BigText(
                    text: "ĐĂNG NHẬP",
                    size:  ScreenUtil().setSp(15),
                    color: Colors.white,
                  ),
                )
              ),
            ),
            SizedBox(height:  ScreenUtil().setHeight(50)),

            RichText(
                text: TextSpan(
                    text: "Chưa có tài khoản? ",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: ScreenUtil().setSp(20)
                    ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage()),
                    text: " Đăng ký",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: AppColors.mainBlackColor,
                        fontSize: ScreenUtil().setSp(25)
                    ),),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage()),
                      text: " Quên mật khẩu",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainBlackColor,
                          fontSize: ScreenUtil().setSp(25)
                      ),)
                  ]
                )),

          ],
        ),
      ) ,
    );
  }
}
