

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';

class ToolbarWidget extends StatelessWidget
{
  final String text;
  ToolbarWidget(this.text);
  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      elevation: 6,
      child: Container(
          height: 60,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context,true);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image.asset('images/back_icon.png',
                        width: 10.3, height: 10.3),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Center(
                    child: Container(
                      child: Text(
                        text,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14,
                            color: MyColor.textBlueColor,
                            decoration: TextDecoration.none,
                            fontFamily: 'GilroySemibold'),
                      ),
                    )),
                flex: 5,
              ),
              Expanded(
                child: Container(
                    height: 40.3,
                    width: 25.3,
                    margin: EdgeInsets.only(right: 10),
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage(
                              "images/avatorf.png",
                            )))),
                flex: 1,
              )
            ],
          )),
    );
  }

}