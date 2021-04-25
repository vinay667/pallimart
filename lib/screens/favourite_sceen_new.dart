import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/screens/product_detail.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/constants.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/widgets/favourite_list_item.dart';
import 'package:http/http.dart' as http;
import 'package:pallimart/widgets/search_box_widget.dart';
import 'package:toast/toast.dart';

class FavouriteScreenNew extends StatefulWidget {
  String scategoryId;
  bool showToolbar;

  FavouriteScreenNew(this.scategoryId, this.showToolbar);

  @override
  _FavouriteScreenNewState createState() =>
      _FavouriteScreenNewState(scategoryId, showToolbar);
}

class _FavouriteScreenNewState extends State<FavouriteScreenNew> {
  String scategoryId;
  List<dynamic> productList = [];
  bool showToolbar;
  List<dynamic> searchList = [];
  String productCount = '0';
  var textControllerSearch = new TextEditingController();

  _FavouriteScreenNewState(this.scategoryId, this.showToolbar);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showToolbar == false
                  ? Container()
                  : Card(
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
                                    Navigator.pop(context, true);
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
                                    'Products',
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
                height: 5,
              ),

              // search box
              Card(
                margin: EdgeInsets.only(left: 25, right: 25, top: 25),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  child: TextField(
                      controller: textControllerSearch,
                      expands: false,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                productCount = '0';
                              });
                              searchProducts();
                            },
                            child: Image.asset(
                              'images/icon_search.png',
                              width: 20,
                              height: 20,
                              color: MyColor.themeColor,
                            ),
                          ),
                          hintText: "Search for brand & products",
                          hintStyle:
                              TextStyle(color: MyColor.homeItemSubTitleColor),
                          contentPadding: const EdgeInsets.only(
                              left: 12, bottom: 1.0, top: 1.0, right: 12),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              )),
                          fillColor: MyColor.whiteColor),
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                      textInputAction: TextInputAction.search,
                      maxLines: 1,
                      onChanged: (text) {
                        if (textControllerSearch.text == '') {
                          setState(() {
                            productCount = productList.length.toString();
                          });
                        }
                      }),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Text(
                  '(Total products ' + productCount + ')',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Geomanist'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: textControllerSearch.text.length == 0
                    ? GridView.builder(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 16,
                            childAspectRatio: .8),
                        itemCount: productList.length,
                        itemBuilder: (BuildContext context, int index) {
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
                              child: Padding(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: FavouriteListItem(
                                      productList[index]['products']
                                          ['productImage'],
                                      productList[index]['products']
                                          ['productName'],
                                      productList[index]['products']
                                              ['productPrice']
                                          .toString(),
                                      productList[index]['products']
                                          ['productPerimeter'],
                                      productList[index]['products']
                                              ['productQuantity']
                                          .toString())));
                        })
                    : GridView.builder(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 16,
                            childAspectRatio: .8),
                        itemCount: searchList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => ProductDetail(
                                            searchList[index]['id'].toString(),
                                            searchList[index]['productName'],
                                            searchList[index]['productQuantity']
                                                    .toString() +
                                                ' ' +
                                                searchList[index]
                                                    ['productPerimeter'],
                                            searchList[index]['productPrice']
                                                .toString(),
                                            Constants.imageBaseUrl +
                                                searchList[index]
                                                    ['productImage'],
                                            searchList[index]
                                                ['productDescription'],
                                            searchList[index]['subCategoryId']
                                                .toString())));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: FavouriteListItem(
                                    searchList[index]['productImage'],
                                    searchList[index]['productName'],
                                    searchList[index]['productPrice']
                                        .toString(),
                                    searchList[index]['productPerimeter'],
                                    searchList[index]['productQuantity']
                                        .toString()),
                              ));
                        }),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(scategoryId + 'hjvggyvgf');
    checkInternetAPIcall();
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      if (scategoryId == 'NA') {
        getFavOrders();
      } else {
        fetchProducts();
      }
    } else {
      Toast.show(
        'No Internet found !! ',
        context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.lightBlue,
      );
    }
  }

  fetchProducts() async {
    String message = '';
    var formData = {'subCategoryId': scategoryId};
    APIDialog.showAlertDialog(context, 'Please wait...');
    try {
      http.Response response;
      response = await http.post(
          Constants.appBaseUrl + 'product/api/subCategoryProducts',
          body: json.encode(formData),
          headers: {
            "Content-type": "application/json",
            "access-token": UserModel.accessToken
          });
      Navigator.pop(context);
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      setState(() {
        productList = fetchResponse['data'];
        productCount = productList.length.toString();
      });
      if (productList.length == 0) {
        Toast.show(
          'No Products found !! ',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: MyColor.gradientEnd,
        );
      }
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.pop(context);
    }
  }

  searchProducts() async {
    var _fromData = {
      'productName': textControllerSearch.text,
    };
    print(_fromData);
    ApiBaseHelper helper = new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Please wait...');
    var response = await helper.postAPIFormData(
        'product/api/searchProducts', context, _fromData);
    Navigator.pop(context);
    setState(() {
      searchList.clear();
      searchList = response['data'];
      productCount = searchList.length.toString();
    });
    print(response);
  }

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

  getFavOrders() async {
    ApiBaseHelper helper = new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Please wait...');
    var response = await helper.getWithToken(
        'product/api/product/favourite/list', context);
    Navigator.pop(context);
    setState(() {
      productList = response['data'];
      productCount = response['data'].length.toString();
    });

    if (productList.length == 0) {
      Toast.show('No Fav Items found !!!', context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.black);
    }
    print(response);
  }
}
