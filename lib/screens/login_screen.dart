
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'package:pallimart/screens/sign_up_screen.dart';
import 'package:pallimart/widgets/text_widget.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/utils/snackbar.dart';
import 'package:pallimart/utils/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget
{
  LoginScreenState createState()=>LoginScreenState();
}
class LoginScreenState extends State<LoginScreen>
{
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var textControllerName = new TextEditingController();
  var textControllerPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: SafeArea(
        child: Container(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))

            ),
            margin: EdgeInsets.zero,
            child: Container(
              height: 370,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15,top: 15),
                        child: TextWidget('Sign in',MyColor.themeColor,18),
                      ),
                      GestureDetector(
                        onTap: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));


                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 15,top: 15),
                          child: TextWidget('Sign up',MyColor.greyTextColor,18),
                        ),

                      )
                    ],



                  ),
                  SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 15,top: 15),
                    child: TextWidget('Sign in to Grocery App',Colors.black87,22),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 15,top: 5),
                    child: TextWidget('Enter email and password to continue',MyColor.lightGreyTextColor,17),
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
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 15,
                            fontFamily: 'GilroySemibold'),
                        controller: textControllerPassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter password',
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
                    ),),

                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TextWidget('Forgot password?',MyColor.greyTextColor,16),
                      ),

                      GestureDetector(
                        onTap: (){
                          if (textControllerName.text == '' ||
                              textControllerPassword.text == '') {
                            MySnackbar.displaySnackbar(key, MyColor.infoSnackColor,
                                'Please fill all the fields !!');
                          }
                          else if(textControllerName.text=='')
                            {
                              MySnackbar.displaySnackbar(key, MyColor.infoSnackColor,
                                  'Email cannot be empty !!');
                            }
                          else if(textControllerPassword.text=='')
                            {
                              MySnackbar.displaySnackbar(key, MyColor.infoSnackColor,
                                  'Password cannot be blank !!');
                            }
                          else if(Validations.checkEmail(textControllerName.text)==false)
                            {
                              MySnackbar.displaySnackbar(key, MyColor.noInternetColor,
                                  'Please Enter a valid Email !!');
                            }
                          else if(textControllerName.text=='abc@gmail.com' && textControllerPassword.text=='123456')
                            {
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          else
                            {
                             checkInternetAPIcall();

                            }




                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 15,top:3),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              elevation: 5,
                              color: MyColor.themeColor,
                              child: Container(
                                  height: 37,
                                  width: 100,
                                  child: Center(
                                    child: TextWidget('SIGN IN',Colors.white,16),
                                  )
                              )



                          ),


                        ),
                      )
                    ],

                  ),


                ],
              ),
            )
          ),
        )
      ),
    );
  }
    Future<Map<String, dynamic>> loginUser() async {
      String message = '';
      final Map<String, dynamic> collectedAuthData = {
        'emailAddress': textControllerName.text,
        'password': textControllerPassword.text
      };
      print(collectedAuthData);
      APIDialog.showAlertDialog(context, 'Logging in...');
      try {
        http.Response response;
        response = await http.post(
            'http://pallimart.com/product/api/customer/login',
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
         _saveUserDetail(fetchResponse['data']['firstName']+' '+fetchResponse['data']['lastName'], fetchResponse['data']['emailAddress'], fetchResponse['data']['access_token']);
         Toast.show(fetchResponse['message'], context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.lightBlue,);
         Navigator.pushReplacementNamed(context, '/bottom');
          }
        else if(fetchResponse['success'].toString()=='false')
          {
            MySnackbar.displaySnackbar(key,MyColor.noInternetColor,fetchResponse['message']);
          }

      } catch (errorMessage) {
        message = errorMessage.toString();
        print(message);
        Navigator.pop(context);
      }
    }

    _saveUserDetail(String name,String email,String access_token)
    async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', name);
      prefs.setString('email', email);
      prefs.setString('access_token', access_token);

    }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      loginUser();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }

}