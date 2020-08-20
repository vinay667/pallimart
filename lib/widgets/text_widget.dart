
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';

class TextWidget extends StatelessWidget {
  String text;
  Color color;
  double fontSize;
  TextWidget(this.text,this.color,this.fontSize);

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: TextStyle(fontSize: fontSize,color: color,fontFamily: 'GilroySemibold',fontWeight: FontWeight.bold),
    );
  }
}

