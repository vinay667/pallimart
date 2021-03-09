import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pallimart/callbacks/button_click_callback.dart';
import 'package:pallimart/callbacks/text_field_callback.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/constants2.dart';
import 'package:pallimart/widgets/appbar_title.dart';
import 'package:pallimart/widgets/button_widget.dart';
import 'package:pallimart/widgets/text_input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    implements TextFieldCallback, ButtonClickListener {
  String _password;
  String _email, _phoneNumber, _userName;
  final FocusNode emailFocus = FocusNode();
  File _image;
  final picker = ImagePicker();
  var textControllerName = new TextEditingController();
  var textControllerEmail = new TextEditingController();
  var textControllerLastName = new TextEditingController();
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
                        _userName,
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
                      MyTextInputField(this, 'First Name:','first name',
                          userNameFocus, phoneNumberFocus,textControllerName),
                      MyTextInputField(this, 'Last Name:', 'last name',
                          phoneNumberFocus, emailFocus,textControllerLastName),
                      MyTextInputField(this, 'Email Id:', 'email', emailFocus,
                          passwordFocus,textControllerEmail),
                      MyTextInputField(
                          this, 'Password', 'password', passwordFocus, null,null),
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
  setUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('name') ?? '';
      textControllerName.text=_userName;
      textControllerEmail.text=prefs.getString('email') ?? '';
     // userEmail = prefs.getString('email') ?? '';
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserData();
  }
  @override
  void onButtonClickListener(int id) {
    if (id == Constants2.BUTTON_CLICK_ID) {
      updateUserProfile();
  /*    if (_key.currentState.validate()) {
        _key.currentState.save();
      }*/
    }
  }
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  updateUserProfile() async {
    var _fromData = {
      'firstName': textControllerName.text,
      'lastName':textControllerLastName.text,
      'emailAddress':textControllerEmail.text
    };
    ApiBaseHelper helper=new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Updating profile...');
    try{
      var response=await helper.postAPIFormData('product/api/customer/update', context,_fromData);
      Navigator.pop(context);

      if(response['status'])
        {
          Toast.show('Profile Updated Successfully !!', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.black);
          Navigator.pop(context);
          print(response.toString());
        }



    }
    catch (errorMessage) {
      String message = errorMessage.toString();
      print(message);
      Navigator.pop(context);
    }

  }


}
