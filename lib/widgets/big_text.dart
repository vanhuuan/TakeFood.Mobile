import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  int maxLines;


  BigText(
      {Key? key,
        this.color=const Color(0xFF332d2b),
        required this.text,
        this.size = 0,
        this.maxLines=1,
        this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overFlow,
      style: TextStyle(
        fontFamily: 'Inter',
        color: color,
        fontSize: size==0?ScreenUtil().setSp(13):size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}