
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'package:pallimart/screens/login_screen.dart';
import 'package:pallimart/screens/social_sign_up_screen.dart';
import 'package:pallimart/widgets/text_widget.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/utils/snackbar.dart';
import 'package:pallimart/utils/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'home.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class SignUpScreen extends StatefulWidget
{
  SignUpScreenState createState()=>SignUpScreenState();
}
class SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  var textControllerName = new TextEditingController();
  var textControllerEmail = new TextEditingController();
  var textControllerPassword = new TextEditingController();
  GoogleSignInAccount _currentUser;
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _contactText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: key,
      body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))

                    ),
                    margin: EdgeInsets.zero,
                    child: Container(
                      height: 550,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 15),
                                child: TextWidget(
                                    'Sign Up', MyColor.themeColor, 18),
                              ),
                              GestureDetector(
                                onTap: (){

                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 15, top: 15),
                                  child: TextWidget(
                                      'Sign In', MyColor.greyTextColor, 18),
                                ),

                              )
                            ],


                          ),
                          SizedBox(height: 25),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 15, top: 15),
                            child: TextWidget(
                                'Welcome to Grocery App', Colors.black87, 22),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 15, top: 5),
                            child: TextWidget(
                                'Lets get started !' ,
                                MyColor.lightGreyTextColor, 17),
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
                                  hintText: 'Enter Name',
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
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Divider(
                              color: MyColor.lightGreyTextColor,
                            ),
                          ),
                          SizedBox(height: 20),

                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Container(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 15,
                                    fontFamily: 'GilroySemibold'),
                                controller: textControllerEmail,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your email',
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
                            padding: EdgeInsets.only(left: 15, right: 15),
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
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Divider(
                              color: MyColor.lightGreyTextColor,
                            ),),

                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: TextWidget(
                                    '', MyColor.greyTextColor, 16),
                              ),

                              GestureDetector(
                                onTap: () {

                                  if (textControllerName.text == '' || textControllerEmail.text == '' ||
                                      textControllerPassword.text == '') {
                                    MySnackbar.displaySnackbar(key, MyColor.infoSnackColor,
                                        'Please fill all the fields !!');
                                  }


                                  else if(Validations.checkEmail(textControllerEmail.text)==false)
                                  {
                                    MySnackbar.displaySnackbar(key, MyColor.noInternetColor,
                                        'Please Enter a valid Email !!');
                                  }
                                  else
                                  {
                                    checkInternetAPIcall();
                                  }

                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 15, top: 3),
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
                                            child: TextWidget(
                                                'SIGN UP', Colors.white, 16),
                                          )
                                      )


                                  ),


                                ),
                              )
                            ],

                          ),

                          SizedBox(height: 15,),
                          Text(
                            'Or Sign up with',
                            style: TextStyle(
                                color: MyColor.textColorBlue,
                                fontSize: 17,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 15,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[


                              InkWell(
                                onTap: (){

                                 // _handleSignOut();
                                  _handleSignIn();

                    },



                                child: Image.asset('images/google_ic.png',width: 60,height: 60,),
                              ),
                              SizedBox(width: 15),
                              InkWell(
                                onTap: (){
                                  _logOut();
                                  _login();
                                },
                                child:  Image.asset('images/fb_ic.png',width: 60,height: 60,),
                              )


                            ],
                          )





                        ],
                      ),
                    )
                ),
              )
            ],
          )
      ),
    );
  }
 createUser() async {
    String message = '';
    final Map<String, dynamic> collectedAuthData = {
      'emailAddress': textControllerEmail.text,
      'password': textControllerPassword.text,
      'firstName': textControllerName.text,
      'lastName': 'S',
      'phoneNumber': '9999999999',
      'address': 'India',
    };
    print(collectedAuthData);
    APIDialog.showAlertDialog(context, 'Creating account...');
    try {
      http.Response response;
      response = await http.post(
          'https://pallimart.com/product/api/customer/register',
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
          print(fetchResponse['message']);
          Toast.show(fetchResponse['message'], context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.lightBlue,);
          Navigator.pop(context,true);
        }
      else
        {
          print(fetchResponse['message']);
          MySnackbar.displaySnackbar(key, MyColor.noInternetColor, fetchResponse['message']);
        }

    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.pop(context);
    }
  }



  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      createUser();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleSignOut();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        Toast.show('Logged In Successfully !!', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.black,);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SocialSignUpScreen(_currentUser.displayName,_currentUser.email)),
                (Route<dynamic> route) => false);
      }
    });
    _googleSignIn.signInSilently();




  }

  Future<Null> _login() async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
       // final FacebookAccessToken accessToken = result.accessToken;

        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result
                .accessToken.token}');

        var profile = json.decode(graphResponse.body);

        print(profile.toString());
        Toast.show('Logged In Successfully !!', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.black,);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SocialSignUpScreen(profile['name'],profile['email'])),
                (Route<dynamic> route) => false);


        break;
      case FacebookLoginStatus.cancelledByUser:
       print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        print(result.errorMessage);
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
   // _showMessage('Logged out.');
  }
}