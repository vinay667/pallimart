import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';

class CustomContainer extends StatelessWidget {
  final String labelText;
  final FocusNode focusNode;
  final Function onTap;
  final String hintText;
  final Color textBgColor;
  final bool isEnabled;
  var controller;
  String rightIcon;

   CustomContainer({this.labelText,this.focusNode,this.onTap,this.hintText,this.textBgColor,this.isEnabled,this.controller,this.rightIcon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(

          height: 80,
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: (){
              onTap();
            },
            child: Container(
                width: MediaQuery.of(context).size.width-60,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: focusNode.hasFocus? Colors.greenAccent:MyColor.grey, width: 1.5),
                ),
                child:TextFormField(

                  controller: controller,
                  enabled: isEnabled==null?true:isEnabled,
                  focusNode: focusNode,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: MyColor.textColorBlue,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700),
                  decoration: new InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(40,43,47,0.25),
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    fillColor: Colors.white,
                    //  contentPadding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 20),
                    contentPadding: EdgeInsets.only(left: 10,top: 10,bottom: 10,right: 38),
                    //fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.emailAddress,
                )
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 45,
          child: Container(color: textBgColor, child: Padding(
            padding: EdgeInsets.only(left: 5,right: 5),
            child: Text(labelText,style:TextStyle(
    color: focusNode.hasFocus
    ? Colors.greenAccent
        : Color.fromRGBO(40,43,47,0.8),
            fontSize: 14,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600

            ),
          )),
        )),

        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: (){
              onTap();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 12,top: 40),
              child: Image.asset(rightIcon==null?'':rightIcon,width: 22,height: 25,),
            ),
          )
        )

      ],
    );
  }
}
