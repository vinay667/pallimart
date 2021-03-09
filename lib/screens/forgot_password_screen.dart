
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/screens/sign_up_screen.dart';
import 'package:pallimart/screens/login_demo.dart';
import 'package:pallimart/screens/social_sign_up_screen.dart';
import 'package:pallimart/utils/constants.dart';
import 'package:pallimart/widgets/text_widget.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/utils/snackbar.dart';
import 'package:pallimart/utils/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'home.dart';

class ForgotPasswordScreen extends StatefulWidget
{
  ForgotPasswordState createState()=>ForgotPasswordState();
}
class ForgotPasswordState extends State<ForgotPasswordScreen>
{
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var textControllerName = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: SafeArea(
        child: Container(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))

            ),
            margin: EdgeInsets.zero,
            child: Container(
              height: 290,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:  Padding(
                          padding: EdgeInsets.only(left: 15,top: 15),
                          child:   Image.asset('images/back_icon.png', width: 30, height: 17,color: MyColor.themeColor,),
                        ),
                      )
                    ],



                  ),
                  SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 15,top: 15),
                    child: TextWidget('Forgot Password',Colors.black87,22),
                  ),

                  SizedBox(height: 25,),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 15,
                            fontFamily: 'GilroySemibold'),
                        controller: textControllerName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter email',
                          hintStyle: TextStyle(
                            color: MyColor.lightGreyTextColor,
                            fontSize: 15,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      height: 40,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: Divider(
                      color: MyColor.lightGreyTextColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      FocusScope.of(context).unfocus();
                      if(textControllerName.text=='')
                      {
                        Toast.show('Email cannot be empty !!', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.black,);

                      }
                      else if(Validations.checkEmail(textControllerName.text)==false)
                      {
                        Toast.show('Please Enter a valid Email !!', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.black,);
                      }
                      else
                      {
                        checkInternetAPIcall();
//
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 15,top:3),
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          elevation: 10,
                          color: MyColor.themeColor,
                          child: Container(
                              height: 50,
                              width: double.infinity,
                              child: Center(
                                child: TextWidget('Forgot Password',Colors.white,16),
                              )
                          )



                      ),


                    ),
                  ),
                  SizedBox(height: 20),









                ],
              ),
            )
          ),
        )
      ),
    );
  }
    forgotPassword() async {
      String message = '';
      final Map<String, dynamic> collectedAuthData = {
        'email': textControllerName.text,
      };
      print(collectedAuthData);
      APIDialog.showAlertDialog(context, 'Please wait...');
      try {
        http.Response response;
        response = await http.post(
            Constants.appBaseUrl+'product/api/forgot/password',
            body: json.encode(collectedAuthData),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'X-Requested-With': 'XMLHttpRequest',
            });
        Map<String, dynamic> fetchResponse = json.decode(response.body);
        print(fetchResponse);
        Navigator.pop(context);
        if(fetchResponse['success'].toString()=='true')
          {
         Toast.show(fetchResponse['message'], context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.black,);
         Navigator.pop(context);
          }
        else if(fetchResponse['success'].toString()=='false')
          {
            Toast.show(fetchResponse['message'], context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.black,);

          }

      } catch (errorMessage) {
        message = errorMessage.toString();
        print(message);
        Navigator.pop(context);
      }
    }



  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      forgotPassword();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPageData();


  }
  setPageData()
  async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString('page_value', 'login');
  }
}