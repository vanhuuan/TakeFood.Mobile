
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType textInputType;
  const AppTextField({Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.obscureText=false,
    this.textInputType=TextInputType.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: ScreenUtil().setHeight(20),right: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(1,10),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        controller: textController,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon,color: AppColors.mainColor,),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),
                borderSide: BorderSide(
                  width: 0.5,
                  color: Colors.white,
                )
            ),
            enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )
            ),
            border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(30)),

            )

        ),
        style: TextStyle(fontSize: ScreenUtil().setSp(10)),
      ),
    );
  }
}
