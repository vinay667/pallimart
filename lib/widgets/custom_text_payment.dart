import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
class CustomTextPayment extends StatelessWidget {
  CustomTextPayment(
      this.text
      );

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: TextStyle(
            fontSize: 18,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w600,
            color: MyColor.textBlueColor,
            letterSpacing: 0.23,
            decoration: TextDecoration.none)

    );
  }
}