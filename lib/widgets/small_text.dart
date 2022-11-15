import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  int maxLines;
  String fontWeight;
  SmallText(
      {Key? key,
        this.color=const Color(0xFFccc7c5),
        required this.text,
        this.maxLines=5,
        this.size = 10,
        this.height=1.2,
        this.fontWeight="normal"
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: fontWeight=="normal"?FontWeight.normal:FontWeight.bold,
        fontFamily: 'Inter',
        color: color==const Color(0xFFccc7c5)?const Color(0xFFccc7c5):color,
        fontSize: size,
        height: height
      ),
    );
  }
}
