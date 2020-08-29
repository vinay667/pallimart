import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/network/app_exceptions.dart';
import 'package:pallimart/utils/constants.dart';
import 'package:toast/toast.dart';

class ApiBaseHelper {
  final String _baseUrl = Constants.appBaseUrl;

  Future<dynamic> get(String url, BuildContext context) async {
    var responseJson;
    print(_baseUrl+url);
    //String accessToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZTIyM2VmNTcyZWEyYThiMDIzYzI4YTkxNDFmZWYwNjNiMmUxNzNjMjkxMGZiMWZmZjc3OTA4MTMzMDIyYmI5MjNiNTQ3OTA1Mzc0MmZjMmUiLCJpYXQiOjE1OTQ5MDM2NTcsIm5iZiI6MTU5NDkwMzY1NywiZXhwIjoxNjI2NDM5NjU3LCJzdWIiOiI0Iiwic2NvcGVzIjpbXX0.ENADEr1LITY5hjQjlqpA09iQSwL-3OMFLL0Q0EeOvtYWtGsKIxj4JncDztKbC4XFn6TZSXzCeCsl3Bgbp5_-reVsQfWwcNkG7r0nvMADngMMV6uTnjn9OSg_75gc59AlmwgHCNtYW0qZRgoKBxn0i4MGeESV1dV7nwruluhVz7qO9rmA9qZZtIJIjecWKWJTa09jxjsKlXNISr7ft9E6f6rfes6-0knPkKpoveSHXqjtGOpnupM9ZDyIDcJjWnI4YHoomW2PjSbiWqOHJJVV4DInDASSbah_swj6XPHczEEz-1iHlGIdOUrkooKu1KtgC8DmKwenoADdY0S4puAdllof-hxpBHEKfX00jBN7JZYvjJyXbZP5zoZ3ACcuNfgP28HrfMdOQMC1EnhXV-wzsZxSn991DE7fzBZ1jKztP4HTFcXfUioecSnxZkxIDu4sbY3gQDi1up_rM2Pwoh_uhJ-0Cm0tjifdvGT9KU0rJIdsFV0tqMAxhcZtTGwHVc4SWBRUWMYeCl-DyeDABA0Y5WWMpeDx2XSBbwP5lNrmtl1Yg56siSwSxlr5V_eNp8WFvYxyt6yNdJ76WRERBWrflBIq6ReiNj8AQiRKdna1vyN0yuD8Rr3G686Dyl5Frj5qDfW70gbppprJ_KeiDgFeLqlyztZRP78gCJhJMO-6n6M';
    try {
      final response = await http.get(_baseUrl + url, headers: {
        'Content-Type': 'application/json',
      });
      responseJson = _returnResponse(response, context);
    } on SocketException {

      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getWithToken(String url, BuildContext context) async {
    var responseJson;
    print(_baseUrl+url);
    String accessToken=UserModel.accessToken;
    try {
      final response = await http.get(_baseUrl + url, headers: {
        'Content-Type': 'application/json',
        'access-token':accessToken
      });
      print(response.statusCode.toString());
      if(response.statusCode==500)
        {
          Navigator.pop(context);
           Toast.show('Internal Server error !!', context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red);
        }
      responseJson = _returnResponse(response, context);
    } on SocketException {

      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }



  Future<dynamic> postAPI(
      String url, BuildContext context) async {
    var responseJson;
    String accessToken=UserModel.accessToken;
    print(_baseUrl+url);
    try {
      final response = await http.post(_baseUrl + url,
          headers: {'Content-Type': 'application/json','access-token':accessToken});
      responseJson = _returnResponse(response, context);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  Future<dynamic> postAPIFormData(
      String url, BuildContext context, var apiParams) async {
    var responseJson;
    String accessToken=UserModel.accessToken;
    print(accessToken);
    print(_baseUrl+url);
    try {
      final response = await http.post(_baseUrl + url,
          body: json.encode(apiParams),
          headers: {
          "Content-type": "application/json","access-token":accessToken});
      print(response.toString()+'ffgrg');
      responseJson = _returnResponse(response, context);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }



  dynamic _returnResponse(http.Response response, BuildContext context) {
    var responseJson = jsonDecode(response.body.toString());
    print(responseJson);
    print(response.statusCode.toString()+'ret');
    switch (response.statusCode) {
      case 200:
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        Toast.show(responseJson['error'].toString(), context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red);
        break;
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
       /* Toast.show('Internal Server error !!', context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.red);
        break;*/
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
