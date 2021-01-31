
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/screens/login_screen.dart';
class LoginDialog
{

  static Future<void> showLogInDialog(BuildContext context,String dialogText) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes,Login"),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context, CupertinoPageRoute(builder:(context)=>LoginScreen()));


      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log in"),
      content: Text(dialogText),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}





