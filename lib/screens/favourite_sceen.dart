import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/screens/product_detail.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/constants.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/widgets/favourite_list_item.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class FavouriteScreen extends StatefulWidget {
  String scategoryId;
  FavouriteScreen(this.scategoryId);
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState(scategoryId);
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  String scategoryId;
  List<dynamic> productList=[];
  String productCount='0';
  _FavouriteScreenState(this.scategoryId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            scategoryId=='NA'?
            Container():Card(
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
              height: 16,
            ),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                '(Total products '+productCount+')',
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
              child: GridView.builder(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 16,
                      childAspectRatio: .8),
                  itemCount: productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>ProductDetail(productList[index]['id'].toString(),productList[index]['productName'],productList[index]['productQuantity'].toString()+' '+productList[index]['productPerimeter'],productList[index]['productPrice'].toString(),Constants.imageBaseUrl+productList[index]['productImage'],productList[index]['productDescription'])));

                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        child: FavouriteListItem(productList[index]['productImage'],productList[index]['productName'],productList[index]['productPrice'].toString(),productList[index]['productPerimeter'],productList[index]['productQuantity']),
                      )
                    );
                  }),
            ),
          ],
        ),
      )
    );
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(scategoryId+'hjvggyvgf');
    checkInternetAPIcall();



  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      if(scategoryId=='NA')
        {
          fetchProductsNormal();
        }
      else{

        fetchProducts();
      }
    } else {
      Toast.show('No Internet found !! ', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.lightBlue,);

    }
  }

  Future<Map<String, dynamic>> fetchProducts() async {
    String message = '';
    var formData={
      'subCategoryId':scategoryId
    };
    APIDialog.showAlertDialog(context, 'Please wait...');
    try {
      http.Response response;
      response = await http.post(
          Constants.appBaseUrl+'product/api/subCategoryProducts',
          body: json.encode(formData),
          headers: {
            "Content-type": "application/json","access-token":UserModel.accessToken}
      );
      Navigator.pop(context);
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      setState(() {
        productList=fetchResponse['data'];
        productCount=productList.length.toString();
      });
      if(productList.length==0)
        {
          Toast.show('No Products found !! ', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: MyColor.gradientEnd,);

        }
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.pop(context);
    }
  }
  Future<Map<String, dynamic>> fetchProductsNormal() async {
    String message = '';
    APIDialog.showAlertDialog(context, 'Please wait...');
    try {
      http.Response response;
      response = await http.get(
        Constants.appBaseUrl+'product/api/allProductCategoryData',
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
        productList=fetchResponse['data']['product'];
        productCount=productList.length.toString();
      });

      // print(todayDealList.length.toString()+'dgff');

      Navigator.pop(context);
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.pop(context);
    }
  }

}
