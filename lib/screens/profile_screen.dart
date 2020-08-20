import 'package:flutter/material.dart';
import 'package:pallimart/callbacks/button_click_callback.dart';
import 'package:pallimart/callbacks/text_field_callback.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/utils/constants2.dart';
import 'package:pallimart/widgets/appbar_title.dart';
import 'package:pallimart/widgets/button_widget.dart';
import 'package:pallimart/widgets/text_input_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    implements TextFieldCallback, ButtonClickListener {
  String _password;
  String _email, _phoneNumber, _userName;
  final FocusNode emailFocus = FocusNode();
  final FocusNode userNameFocus = FocusNode();
  final FocusNode phoneNumberFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyColor.whiteColor,
        body: Form(
            key: _key,
            child: Column(children: <Widget>[
              Expanded(
                  child: ListView(
                children: <Widget>[
                  Stack(children: <Widget>[
                    Image.asset(
                      'images/ellipse_account.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      height: screenSize.height / 5,
                    ),
                    Container(
                        height: screenSize.height / 5 + 32,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      width: 56,
                                      child: InkWell(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: Icon(
                                            Icons.keyboard_backspace,
                                            color: MyColor.whiteColor,
                                          ))),
                                  AppbarTitleText(
                                    title: 'My Profile',
                                    color: MyColor.whiteColor,
                                  ),
                                  Container(
                                    width: 56,
                                  )
                                ]),
                            Expanded(
                              child: Container(),
                            ),
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: MyColor.whiteColor,
                                  child: CircleAvatar(
                                    radius: 38,
                                    backgroundColor: MyColor.whiteColor,
                                    backgroundImage:
                                        AssetImage('images/grocery.png'),
                                  ),
                                ),
                                Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    color: MyColor.blackColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'images/icon_edit.png',
                                  ),
                                )
                              ],
                            ),
                          ],
                        ))
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Angelina Mark",
                        style: TextStyle(
                            fontSize: 18,
                            color: MyColor.homeTitleColor,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    children: <Widget>[
                      MyTextInputField(this, 'Name:', 'user_name',
                          userNameFocus, phoneNumberFocus),
                      MyTextInputField(this, 'Phone No:', 'phone',
                          phoneNumberFocus, emailFocus),
                      MyTextInputField(this, 'Email Id:', 'email', emailFocus,
                          passwordFocus),
                      MyTextInputField(
                          this, 'Password', 'password', passwordFocus, null),
                    ],
                  ),
                ],
              )),
              MyButton(callback: this, title: "Save Changes")
            ])));
  }

  @override
  void onInputFieldSave(String id, String value) {
    switch (id) {
      case 'user_name':
        _userName = value;
        break;
      case 'email':
        _email = value;
        break;
      case 'phone':
        _phoneNumber = value;
        break;
      case 'password':
        _password = value;
        break;
    }
  }

  @override
  void onButtonClickListener(int id) {
    if (id == Constants2.BUTTON_CLICK_ID) {
      if (_key.currentState.validate()) {
        _key.currentState.save();
      }
    }
  }
}
