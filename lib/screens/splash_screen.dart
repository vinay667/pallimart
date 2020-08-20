
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/screens/bottom_tab_screen.dart';
import 'package:pallimart/utils/slider_layout_view.dart';
import 'home.dart';
class SplashScreen extends StatefulWidget {
  String token;
  SplashScreen(this.token);
  @override
  _SplashScreenState createState() => _SplashScreenState(token);
}

class _SplashScreenState extends State<SplashScreen> {
  String token;
  _SplashScreenState(this.token);
  @override
  void initState() {
    super.initState();//28c17e
    Timer(
        Duration(seconds: 3),
            () =>
                token=='notLogin'?
                Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SliderLayoutView())):
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => BottomTabScreen()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.themeColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Container(
                      height: 145,
                      width: 140,
                      child: Center(child: Image.asset('images/app_logo.png',width: 100,height: 100,),),
                    ),



                  ),
                ),
              Container(
                padding: EdgeInsets.only(top: 20),
                transform: Matrix4.translationValues(00.0, -60.0, 0.0),
                child:  Text(
                  'PALLIMARKET',
                  style: TextStyle(fontSize: 22,color: Colors.white,fontFamily: 'GilroySemibold',fontWeight: FontWeight.bold,letterSpacing: 3),

                ),
              )




              /*Container(
                width: double.infinity,
                child:  Align(
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'P',
                        style: TextStyle(fontSize: 19,color: Colors.white,fontFamily: 'GilroySemibold',fontWeight: FontWeight.bold),

                      ),
                      Text(
                        'ALLI',
                        style: TextStyle(fontSize: 19,color: Colors.white,fontFamily: 'GilroySemibold',fontWeight: FontWeight.bold),

                      )




                    ],


                  ),


                ),

              )
*/


              ],



            ),
          ),



        )



      )
    );
  }
}