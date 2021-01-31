import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/screens/favourite_sceen.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/constants.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/widgets/category_list_item.dart';
import 'package:toast/toast.dart';
List<CategoryModel> myList = List<CategoryModel>();

class SubCategoryScreen extends StatefulWidget {
  String categoryId;
  SubCategoryScreen(this.categoryId);
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState(categoryId);
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  String categoryId;
  _SubCategoryScreenState(this.categoryId);
  List<dynamic> productList=[];
  List<dynamic> categoryList=[];
  @override
  void initState() {
    super.initState();
    checkInternetAPIcall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.zero,
                  elevation: 6,
                  child: Container(
                      height: 55,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                               Navigator.pop(context,true);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Image.asset('images/back_icon.png',
                                    width: 10.3, height: 10.3),
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Center(
                                child: Container(
                              child: Text(
                                'Sub Categories',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: MyColor.textBlueColor,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'GilroySemibold'),
                              ),
                            )),
                            flex: 5,
                          ),
                          Expanded(
                            child: Container(
                                height: 40.3,
                                width: 25.3,
                                margin: EdgeInsets.only(right: 10),
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new AssetImage(
                                          "images/avatorf.png",
                                        )))),
                            flex: 1,
                          )
                        ],
                      )),
                ),
            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                'Sub Categories (Total '+ categoryList.length.toString()+')',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GilroySemibold'),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: /*GridView.builder(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: myList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryListItem(item: myList[index]);
                  }),*/

              Container(
                  margin: EdgeInsets.only(right: 10,left: 10),
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                      childAspectRatio: 2/2
                  ),
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext context,int position)
                      {
                        return Container(
                          width: MediaQuery.of(context).size.width/4.3,
                          child: InkWell(
                            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FavouriteScreen(categoryList[position]['id'].toString(),true)));

                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              color: Colors.white,
                              margin: EdgeInsets.only(bottom: 5, left: 4, right: 4, top:5),
                              elevation: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FadeInImage.assetNetwork(
                                    height: 50,
                                    placeholder: 'images/app_logo.png',
                                    image: categoryList[position]['subCategoryImage']!=null?Constants.imageBaseUrl+categoryList[position]['subCategoryImage']:'',
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    categoryList[position]['subCategoryName'],
                                    style: TextStyle(
                                        color: MyColor.homeTextColor,
                                        fontSize: 16,
                                        fontFamily: "Gilroy",
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          )
                        );

                      })


              ),
            ),




          ],
        ),


      ),


    );
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      fetchProducts();
    } else {
      Toast.show('No Internet found !! ', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.lightBlue,);

    }
  }

  Future<Map<String, dynamic>> fetchProducts() async {
    String message = '';
    var formData={
      'categoryId':categoryId
    };
    APIDialog.showAlertDialog(context, 'Please wait...');
    try {
      http.Response response;
      response = await http.post(
        Constants.appBaseUrl+'product/api/categorySubCategory',
        body: json.encode(formData),
          headers: {
            "Content-type": "application/json","access-token":UserModel.accessToken}
      );
      Navigator.pop(context);
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      setState(() {
        // productList=fetchResponse['data']['product'];
        categoryList=fetchResponse['data'];
      });

    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.pop(context);
    }
  }
}
