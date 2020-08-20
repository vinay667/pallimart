import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'constants.dart';

class SlideItem extends StatelessWidget {
  final int index;
  List<String> imagesList=['images/1_u.jpg','images/2_u.jpg','images/3_u.jpg','images/4_u.jpg'];
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
     child: Image.asset(imagesList[index]),
    );
  }
}