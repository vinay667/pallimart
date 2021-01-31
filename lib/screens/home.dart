import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/screens/all_products_screen.dart';
import 'package:pallimart/screens/product_detail.dart';
import 'package:pallimart/screens/sub_category_screen.dart';
import 'package:geolocator/geolocator.dart';

import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/constants.dart';
import 'package:pallimart/utils/login_Dialog.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/utils/snackbar.dart';
import 'package:pallimart/widgets/custom_toolbar.dart';
import 'package:pallimart/screens/login_screen.dart';
import 'package:pallimart/utils/category_model.dart';
import 'package:pallimart/utils/home_list_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'favourite_sceen.dart';

List<CategoryModel> myList = List<CategoryModel>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '', userEmail = '';
  List<dynamic> productList = [];
  List<dynamic> frequentList = [];
  List<dynamic> reverseList = [];
  bool isAPICalled = false;
  List<dynamic> dummyList = [];
  List<dynamic> todayDealList = [];
  List<dynamic> categoryList = [];
  List<dynamic> brandsList = [];
  String currentAddress = 'Fetching Location ...';
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  List<String> exploreBrands = [
    'images/headphone.jpeg',
    'images/purse.jpg',
    'images/dryer.jpeg',
    'images/wifi.jpeg',
    'images/phone44.jpeg',
    'images/phone45.jpeg'
  ];

  @override
  void initState() {
    super.initState();
    setPageData();
    getCurrentLocation();
    checkInternetAPIcall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        body: Builder(
          builder: (ctx) => SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 14, top: 10),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 9, right: 10),
                              child: Text(
                                currentAddress,
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 13.5,
                                    fontFamily: "Gilroy",
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 7, bottom: 10),
                        child: SizedBox(
                            height: 162.0,
                            width: 350.0,
                            child: Carousel(
                              images: [
                                //NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),

                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    "images/1.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),

                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    "images/2.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),

                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    "images/3.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                              dotSize: 4.0,
                              dotSpacing: 15.0,
                              autoplay: true,
                              autoplayDuration: Duration(seconds: 4),
                              dotColor: MyColor.themeColor,
                              indicatorBgPadding: 5.0,
                              dotBgColor:
                                  MyColor.gradientStart.withOpacity(0.2),
                              borderRadius: true,
                            )),
                      ),
                      Container(
                          height: 106,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryList.length,
                              padding: EdgeInsets.only(left: 12, right: 12),
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubCategoryScreen(
                                                    categoryList[index]['id']
                                                        .toString()))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          4.3,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: Colors.white,
                                        margin: EdgeInsets.only(
                                            bottom: 16,
                                            left: 4,
                                            right: 4,
                                            top: 8.0),
                                        elevation: 8.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            /* Image.asset(
                                              categoryImage[index],
                                              height: 42,
                                            ),*/
                                            FadeInImage.assetNetwork(
                                              height: 42,
                                              placeholder:
                                                  'images/app_logo.png',
                                              image: Constants.imageBaseUrl +
                                                  categoryList[index]
                                                      ['categoryImage'],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              categoryList[index]
                                                  ['categoryName'],
                                              style: TextStyle(
                                                  color: MyColor.homeTextColor,
                                                  fontSize: 12,
                                                  fontFamily: "Gilroy",
                                                  fontWeight: FontWeight.w700),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              })),
                      SizedBox(
                        height: 8,
                      ),
                      TitleText("Popular Product"),
                      SizedBox(
                        height: 8,
                      ),
                      GridView.builder(
                          itemCount:
                              productList.length > 10 ? 10 : productList.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 12, right: 12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // crossAxisSpacing: 8,
                                  //mainAxisSpacing: 16,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => ProductDetail(
                                            productList[index]['id'].toString(),
                                            productList[index]['productName'],
                                            productList[index]
                                                        ['productQuantity']
                                                    .toString() +
                                                ' ' +
                                                productList[index]
                                                    ['productPerimeter'],
                                            productList[index]['productPrice']
                                                .toString(),
                                            Constants.imageBaseUrl +
                                                productList[index]
                                                    ['productImage'],
                                            productList[index]
                                                ['productDescription'],
                                            productList[index]['subCategoryId']
                                                .toString())));
                              },
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .45,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(15.0),
                                              topRight:
                                                  const Radius.circular(15.0),
                                            ),
                                            boxShadow: [
                                              new BoxShadow(
                                                color: MyColor.themeColor
                                                    .withOpacity(0.5),
                                                blurRadius: 7.0,
                                              ),
                                            ]),
                                        margin: EdgeInsets.only(
                                            bottom: 42,
                                            left: 4,
                                            right: 4,
                                            top: 5),
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: <Widget>[
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 12,
                                                      right: 12,
                                                      top: 5,
                                                      bottom: 25),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    height: 180.0,
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        'images/app_logo.png',
                                                    image: Constants
                                                            .imageBaseUrl +
                                                        productList[index]
                                                            ['productImage'],
                                                  ),
                                                )),
                                            Image.asset(
                                              'images/icon_fav.png',
                                              height: 36,
                                              width: 36,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 5,
                                          margin: EdgeInsets.only(
                                              bottom: 12, left: 12, right: 12),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .45,
                                            padding: EdgeInsets.only(left: 8),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  productList[index]
                                                      ['productName'],
                                                  style: TextStyle(
                                                      color: MyColor
                                                          .homeItemTitleColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Gilroy'),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                        child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          productList[index][
                                                                      'productQuantity']
                                                                  .toString() +
                                                              ' ' +
                                                              productList[index]
                                                                  [
                                                                  'productPerimeter'],
                                                          style: TextStyle(
                                                              color: MyColor
                                                                  .homeItemSubTitleColor,
                                                              fontSize: 9.3,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'Gilroy'),
                                                        ),
                                                        SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                              'Rs. ' +
                                                                  productList[index]
                                                                          [
                                                                          'productPrice']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: MyColor
                                                                      .homeItemTitleColor,
                                                                  fontSize:
                                                                      10.7,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Gilroy'),
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              "",
                                                              style: TextStyle(
                                                                  color: MyColor
                                                                      .homeItemSubTitleColor,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  fontSize: 7.8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Gilroy'),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (UserModel
                                                                .accessToken ==
                                                            'notLogin') {
                                                          LoginDialog
                                                              .showLogInDialog(
                                                                  context,
                                                                  'Please Login to add a Product !!');
                                                        } else {
                                                          addProduct(
                                                              productList[index]
                                                                  ['id']);
                                                        }
                                                      },
                                                      child: Image.asset(
                                                          'images/home_icon_delete.png'),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  )),
                            );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      productList.length < 11
                          ? Container()
                          : Center(
                              child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllProductScreen('NA')));
                              },
                              child: Container(
                                  width: 100,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColor.themeColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'View All',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: "Gilroy",
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                            )),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(color: MyColor.greyDivider),
                      TitleText("Explore Brands"),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          height: 85,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: brandsList.length,
                              padding: EdgeInsets.only(left: 12, right: 12),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllProductScreen(
                                                    brandsList[index]['id']
                                                        .toString())));
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(left: 4, right: 4),
                                    width:
                                        MediaQuery.of(context).size.width * .38,
                                    child: Column(
                                      children: <Widget>[
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            child: Image.network(
                                              Constants.imageBaseUrl +
                                                  brandsList[index]
                                                      ['brandImage'],
                                              height: 70,
                                            )),
                                        Text(
                                          brandsList[index]['brandName'],
                                          style: TextStyle(
                                              color: MyColor.homeItemTitleColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Gilroy'),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(color: MyColor.greyDivider),
                      TitleText("Today’s deal"),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: reverseList.length > 10
                                  ? 10
                                  : reverseList.length,
                              padding: EdgeInsets.only(left: 12, right: 12),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => ProductDetail(
                                                reverseList[index]['id']
                                                    .toString(),
                                                reverseList[index]
                                                    ['productName'],
                                                reverseList[index]
                                                            ['productQuantity']
                                                        .toString() +
                                                    ' ' +
                                                    reverseList[index]
                                                        ['productPerimeter'],
                                                reverseList[index]
                                                        ['productPrice']
                                                    .toString(),
                                                Constants.imageBaseUrl +
                                                    reverseList[index]
                                                        ['productImage'],
                                                reverseList[index]
                                                    ['productDescription'],
                                                reverseList[index]
                                                        ['subCategoryId']
                                                    .toString())));
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .45,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    new BorderRadius.only(
                                                  topLeft:
                                                      const Radius.circular(
                                                          15.0),
                                                  topRight:
                                                      const Radius.circular(
                                                          15.0),
                                                ),
                                                boxShadow: [
                                                  new BoxShadow(
                                                    color: MyColor.themeColor
                                                        .withOpacity(0.5),
                                                    blurRadius: 7.0,
                                                  ),
                                                ]),
                                            margin: EdgeInsets.only(
                                                bottom: 42,
                                                left: 4,
                                                right: 4,
                                                top: 10),
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    child:
                                                        /*Image.asset(
                                                    Constants.imageBaseUrl+productList[index]['productImage'],
                                                    height: 180,
                                                    fit: BoxFit.fill,
                                                  )*/

                                                        Container(
                                                      margin: EdgeInsets.only(
                                                          left: 12,
                                                          right: 12,
                                                          top: 5,
                                                          bottom: 25),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        height: 180.0,
                                                        fit: BoxFit.fill,
                                                        placeholder:
                                                            'images/app_logo.png',
                                                        image: Constants
                                                                .imageBaseUrl +
                                                            reverseList[index][
                                                                'productImage'],
                                                      ),
                                                    )),
                                                Image.asset(
                                                  'images/icon_fav.png',
                                                  height: 36,
                                                  width: 36,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Card(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 5,
                                              margin: EdgeInsets.only(
                                                  bottom: 12,
                                                  left: 12,
                                                  right: 12),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .45,
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Text(
                                                      reverseList[index]
                                                          ['productName'],
                                                      style: TextStyle(
                                                          color: MyColor
                                                              .homeItemTitleColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Gilroy'),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              reverseList[index]
                                                                          [
                                                                          'productQuantity']
                                                                      .toString() +
                                                                  ' ' +
                                                                  productList[
                                                                          index]
                                                                      [
                                                                      'productPerimeter'],
                                                              style: TextStyle(
                                                                  color: MyColor
                                                                      .homeItemSubTitleColor,
                                                                  fontSize: 9.3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      'Gilroy'),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Rs. ' +
                                                                      reverseList[index]
                                                                              [
                                                                              'productPrice']
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: MyColor
                                                                          .homeItemTitleColor,
                                                                      fontSize:
                                                                          10.7,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          'Gilroy'),
                                                                ),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  "",
                                                                  style: TextStyle(
                                                                      color: MyColor
                                                                          .homeItemSubTitleColor,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                      fontSize:
                                                                          7.8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          'Gilroy'),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (UserModel
                                                                    .accessToken ==
                                                                'notLogin') {
                                                              LoginDialog
                                                                  .showLogInDialog(
                                                                      context,
                                                                      'Please Login to add a Product !!');
                                                            } else {
                                                              addProduct(
                                                                  reverseList[
                                                                          index]
                                                                      ['id']);
                                                            }
                                                          },
                                                          child: Image.asset(
                                                              'images/home_icon_delete.png'),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      )),
                                );
                              })),
                      SizedBox(
                        height: 15,
                      ),
                      TitleText("Frequently Ordered"),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: frequentList.length,
                              padding: EdgeInsets.only(left: 12, right: 12),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => ProductDetail(
                                                frequentList[index]['id']
                                                    .toString(),
                                                frequentList[index]
                                                    ['productName'],
                                                frequentList[index]
                                                            ['productQuantity']
                                                        .toString() +
                                                    ' ' +
                                                    frequentList[index]
                                                        ['productPerimeter'],
                                                frequentList[index]
                                                        ['productPrice']
                                                    .toString(),
                                                Constants.imageBaseUrl +
                                                    frequentList[index]
                                                        ['productImage'],
                                                frequentList[index]
                                                    ['productDescription'],
                                                frequentList[index]
                                                        ['subCategoryId']
                                                    .toString())));
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .48,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    new BorderRadius.only(
                                                  topLeft:
                                                      const Radius.circular(
                                                          15.0),
                                                  topRight:
                                                      const Radius.circular(
                                                          15.0),
                                                ),
                                                boxShadow: [
                                                  new BoxShadow(
                                                    color: MyColor.themeColor
                                                        .withOpacity(0.5),
                                                    blurRadius: 7.0,
                                                  ),
                                                ]),
                                            margin: EdgeInsets.only(
                                                bottom: 42,
                                                left: 4,
                                                right: 4,
                                                top: 10),
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: <Widget>[
                                                // padding: EdgeInsets.only(left: 12,right: 12,top: 5,bottom: 25),
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 12,
                                                          right: 12,
                                                          top: 5,
                                                          bottom: 25),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        height: 180.0,
                                                        fit: BoxFit.fill,
                                                        placeholder:
                                                            'images/app_logo.png',
                                                        image: Constants
                                                                .imageBaseUrl +
                                                            frequentList[index][
                                                                'productImage'],
                                                      ),
                                                    )),
                                                Image.asset(
                                                  'images/icon_fav.png',
                                                  height: 36,
                                                  width: 36,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Card(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 5,
                                              margin: EdgeInsets.only(
                                                  bottom: 12,
                                                  left: 12,
                                                  right: 12),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .45,
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Text(
                                                      frequentList[index]
                                                          ['productName'],
                                                      style: TextStyle(
                                                          color: MyColor
                                                              .homeItemTitleColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Gilroy'),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                            child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              frequentList[index]
                                                                          [
                                                                          'productQuantity']
                                                                      .toString() +
                                                                  ' ' +
                                                                  productList[
                                                                          index]
                                                                      [
                                                                      'productPerimeter'],
                                                              style: TextStyle(
                                                                  color: MyColor
                                                                      .homeItemSubTitleColor,
                                                                  fontSize: 9.3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      'Gilroy'),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Rs. ' +
                                                                      frequentList[index]
                                                                              [
                                                                              'productPrice']
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: MyColor
                                                                          .homeItemTitleColor,
                                                                      fontSize:
                                                                          10.7,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          'Gilroy'),
                                                                ),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  "",
                                                                  style: TextStyle(
                                                                      color: MyColor
                                                                          .homeItemSubTitleColor,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                      fontSize:
                                                                          7.8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          'Gilroy'),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                        GestureDetector(
                                                          onTap: () {
                                                            addProduct(
                                                                frequentList[
                                                                        index]
                                                                    ['id']);
                                                          },
                                                          child: Image.asset(
                                                              'images/home_icon_delete.png'),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      )),
                                );
                              })),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  fetchProducts() async {
    String message = '';
    APIDialog.showAlertDialog(context, 'Please wait...');
    try {
      http.Response response;
      response = await http.get(
        Constants.appBaseUrl + 'product/api/allProductCategoryData',
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      /* dummyList=fetchResponse['data']['product'];
      if(dummyList.length>10)
      {
        for(int i=10;i<=dummyList.length;i++)
        {
          dummyList.removeAt(i);
        }
      }
*/
      setState(() {
        productList = fetchResponse['data']['product'];
        reverseList = productList.reversed.toList();
        categoryList = fetchResponse['data']['category'];
        brandsList = fetchResponse['data']['brand'];
        // todayDealList=dummyList;
      });

      print(productList.toString() + 'dgff');

      Navigator.pop(context);
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.pop(context);
    }
  }

  //add product API

  addProduct(int productId) async {
    var _fromData = {
      'product_id': productId.toString(),
      'product_qty': 1,
    };

    print(_fromData);
    ApiBaseHelper helper = new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Adding to cart...');
    var response = await helper.postAPIFormData(
        'product/api/cart/add', context, _fromData);
    Navigator.pop(context);
    if (response['status'] == 'success') {
      Toast.show('Product added to cart !!', context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: MyColor.themeColor);
    } else {
      Toast.show(response['message'], context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: MyColor.noInternetColor);
    }
    print(response);
  }

  //no internet check

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      fetchProducts();
      frequentlyOrderedProducts();
    } else {
      MySnackbar.displaySnackbar(
          key, MyColor.noInternetColor, 'No Internet found !!');
    }
  }

  getCurrentLocation() async {
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.bestForNavigation, timeInterval: 25);

    geolocator.getPositionStream(locationOptions).listen((Position position) {
      if (!isAPICalled) {
        isAPICalled = true;
        fetchLocationName(position.latitude, position.longitude);
      }
    });
  }

  fetchLocationName(double latt, double long) async {
    print('API called Location Fetch');
    const _host = 'https://maps.google.com/maps/api/geocode/json';
    String apiKey = 'AIzaSyCPFefUcKipTLsFZHXXnx4RuFOX6E-z91M';
    var latitude = latt;
    var longitude = long;

    final uri = Uri.parse('$_host?key=$apiKey&latlng=$latitude,$longitude');
    print(uri);

    try {
      http.Response response = await http.get(uri);
      var responseJson = json.decode(response.body);
      print(responseJson);
      if (response.statusCode == 200) {
        setState(() {
          currentAddress = responseJson['results'][0]['formatted_address'];
        });
      }
    } catch (exception) {
      print(exception.toString());
    }
  }

  frequentlyOrderedProducts() async {
    ApiBaseHelper helper = new ApiBaseHelper();
    var response =
        await helper.getWithToken('product/api/popularProducts', context);
    setState(() {
      frequentList = response['data']['data'];
    });
    print(response);
  }

  setPageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('page_value', 'home');
  }
}

class TitleText extends StatelessWidget {
  final title;

  TitleText(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Text(
        title ?? '',
        style: TextStyle(
            color: MyColor.homeTitleColor,
            fontSize: 18,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
