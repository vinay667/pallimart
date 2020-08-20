import 'package:flutter/material.dart';

class UserModel{

  static String accessToken;
  static String userType;


  static String setAccessToken(String token)
  {
    accessToken=token;
  }
  static String setUserType(String type)
  {
    userType=type;
  }

}
