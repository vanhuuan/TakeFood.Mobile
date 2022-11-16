import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const AppIcon({Key? key,
    required this.icon,
    this.backgroundColor=const Color(0xFFfcf4e4),
   this.iconColor=const Color(0xFFFFFFFF),
     this.size=40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(40),
      height: ScreenUtil().setHeight(35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/3),
      //  color: AppColors.buttonBackgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: size,
      ),
    );
  }
}
