import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:pallimart/colors/colors.dart';

class IconButtonWidget extends StatelessWidget {
  final index;
  final icon;
  final selectedIndex;
  final callBack;

  const IconButtonWidget(
      this.callBack, this.icon, this.index, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => callBack.onButtonClickListener(index),
      iconSize: 27.0,
      icon: selectedIndex == index
          ? ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      MyColor.themeColor,
                      Color(0xFF42D8C0),
                    ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
              child: Image.asset(
                icon,
                color: MyColor.whiteColor,
              ))
          : Image.asset(
              icon,
              color: MyColor.bottomIconColor,
            ),
    );
  }
}
