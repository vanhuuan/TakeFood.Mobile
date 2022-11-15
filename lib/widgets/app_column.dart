import 'package:cdcn/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../utils/colors.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';


class AppColumn extends StatelessWidget {
  final String text;
  final int star;
  final String address;
  final double distance;
  const AppColumn({Key? key,
    required this.text,required this.star,required this.address,required this.distance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BigText(text: text,size: ScreenUtil().setSp(8),),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: AppColors.iconColor1,
                    size: ScreenUtil().setHeight(15),
                  );
                }),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(15),
              ),
              SmallText(text: star.toString()),
            ],
          ),

            IconAndTextWidget(
                icon: Icons.location_on,
                text: "${(distance.toString().substring(0,3))!}km",
                iconColor: AppColors.iconColor1),
          ],
        ),
        SizedBox(
          height:ScreenUtil().setHeight(5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.food_bank_outlined,
                text: address.split(",")[0]!,
                iconColor: AppColors.iconColor1),

          ],
        )
      ],
    );
  }
}
