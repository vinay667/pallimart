import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MySnackbar {
  static void displaySnackbar(final globalKey, Color color, String message) {
    final snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: color,
        content: Text(
          message,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white, fontFamily: 'GilroySemibold', fontSize: 16),
        ));
    globalKey.currentState.showSnackBar(snackBar);
  }
}
