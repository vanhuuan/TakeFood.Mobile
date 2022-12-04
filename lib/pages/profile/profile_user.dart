
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/small_text.dart';
import '../auth/sign_in_page.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Center(child: Text("Cá nhân")),
      ),
      body: SingleChildScrollView(
          child: GetBuilder<UserController>(builder: (user){
            return Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        child: AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: 80,
                          size: 130,
                        ),
                      ),
                      Positioned(
                          top: ScreenUtil().setHeight(100),
                          right: 10,
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.editProfile);
                            },
                            child: Container(
                              child: Row(
                                children: const [
                                  AppIcon(icon: Icons.edit,backgroundColor: Color(0xFFFBC78D), size: 30,iconSize: 25,),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: 20,
                        size: 40,
                      ),
                      smallText: SmallText(
                        text: user.user.name.toString(),
                        color: AppColors.mainBlackColor,
                      )),
                  SizedBox(
                    height: ScreenUtil().setHeight(7),
                  ),
                  AccountWidget(
                      appIcon: const AppIcon(
                        icon: Icons.phone,
                        backgroundColor: Color(0xFFFBC78D),
                        iconColor: Colors.white,
                        iconSize: 20,
                        size: 40,
                      ),
                      smallText: SmallText(
                        text:user.user.phone.toString(),
                        color: AppColors.mainBlackColor,
                      )),
                  SizedBox(
                    height: ScreenUtil().setHeight(7),
                  ),
                  AccountWidget(
                      appIcon: const AppIcon(
                        icon: Icons.mail,
                        backgroundColor: Color(0xFFFBC78D),
                        iconColor: Colors.white,
                        iconSize: 20,
                        size: 40,
                      ),
                      smallText: SmallText(
                        text: user.user.email.toString(),
                        color: AppColors.mainBlackColor,
                      )),
                  SizedBox(
                    height: ScreenUtil().setHeight(7),
                  ),
                  AccountWidget(
                      appIcon: const AppIcon(
                        icon: Icons.location_on_sharp,
                        backgroundColor: Color(0xFFFBC78D),
                        iconColor: Colors.white,
                        iconSize: 20,
                        size: 40,
                      ),
                      smallText: SmallText(
                        text: user.address.toString(),
                        color: AppColors.mainBlackColor,
                      )),
                  SizedBox(
                    height: ScreenUtil().setHeight(7),
                  ),
                  AccountWidget(
                      appIcon: const AppIcon(
                        icon: Icons.store,
                        backgroundColor: Color(0xFFADC965),
                        iconColor: Colors.white,
                        iconSize: 20,
                        size: 40,
                      ),
                      smallText: SmallText(
                        text: "Đăng ký bán hàng",
                        color: AppColors.mainBlackColor,
                      )),
                  SizedBox(
                    height: ScreenUtil().setHeight(7),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(7),
                  ),
                  GestureDetector(
                    onTap: ()  {
                      // Get.find<MyOrderController>().getListMyOrdered();
                      // Get.toNamed(RouteHelper.myOrderPage);
                    },
                    child: AccountWidget(
                        appIcon: const AppIcon(
                          icon: Icons.history,
                          backgroundColor: Color(0xFFADC965),
                          iconColor: Colors.white,
                          iconSize: 20,
                          size: 40,
                        ),
                        smallText: SmallText(
                          text: "Lịch sử đặt hàng",
                          color: AppColors.mainBlackColor,
                        )),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if(await Get.find<UserController>().LogOut()){
                        Get.to(()=>SignInPage());
                      }
                    },
                    child: AccountWidget(
                        appIcon: const AppIcon(
                          icon: Icons.logout,
                          backgroundColor: Color(0xFFD33B23),
                          iconColor: Colors.white,
                          iconSize: 20,
                          size: 40,
                        ),
                        smallText: SmallText(
                          text: "Đăng xuất",
                          color: AppColors.mainBlackColor,
                        )),
                  ),
                ],
              ),
            );
          })
      ),
    );
  }
}
