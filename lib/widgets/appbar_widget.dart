import 'package:flutter/material.dart';
import 'package:pallimart/callbacks/button_click_callback.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/utils/constants2.dart';
import 'package:pallimart/widgets/search_box_widget.dart';
import 'appbar_title.dart';
class AppbarWidget extends AppBar {
  AppbarWidget(
      {BuildContext context,
      ButtonClickListener clickListener,
      int counter,
      bool isBack,
       Function onTap,
      bool isShowAction=true,
      String type,
      String title,
      String actionIcon = 'images/cart.png'})
      : super(
          backgroundColor: MyColor.whiteColor,
          elevation: 0,
          leading: isBack
              ? InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: MyColor.homeTextColor,
                  ))
              : GestureDetector(
            onTap: (){
              onTap();
            },
            child: Padding(
                padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
                child:Container(
                  child: Icon(Icons.dehaze,color: MyColor.themeColor,size: 25),
                )),
          ),
          // you can put Icon as well, it accepts any widget.
          centerTitle: true,
          title: title != null
              ? AppbarTitleText(
                  title: title,
                  color: MyColor.appbarTitle,
                )
              : Container(
                  height: 42,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SearchBoxWidget(
                      clickListener: clickListener,
                      type: type,
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                     MyColor.themeColor,
                      Color(0xFF42D8C0),
                    ]),
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
          actions: isShowAction
              ? [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      InkWell(
                          child: Image.asset(
                            actionIcon,
                            height: 48,
                          ),
                          onTap: () => clickListener
                              .onButtonClickListener(Constants2.CART_ID)),
                      counter != 0
                          ? Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  '$counter',
                                  style: TextStyle(
                                      color: MyColor.whiteColor,
                                      fontFamily: 'Gilory',
                                      fontSize: 7,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : Container()
                    ],
                  )
                ]
              : [],
        );
}
