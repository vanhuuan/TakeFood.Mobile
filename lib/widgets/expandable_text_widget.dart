import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';
import 'small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText=true;
  double textHeight=ScreenUtil().setHeight(70);
  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf=widget.text.substring(0,textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf=widget.text;
      secondHalf="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: secondHalf.isEmpty?SmallText(color:Color(0xFF4D4D4D),size:ScreenUtil().setSp(10),text: firstHalf):Column(
        children: [
          SmallText(height:1.8,color:Color(0xFF4D4D4D),size:ScreenUtil().setSp(10),text: hiddenText?(firstHalf+"..."):(firstHalf+secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
              SmallText(text: "Show more",color: AppColors.mainColor,size: ScreenUtil().setSp(8),),
              Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
