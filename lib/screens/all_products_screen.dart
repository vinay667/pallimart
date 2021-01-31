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
import 'package:toast/toast.dart';

class AllProductScreen extends StatefulWidget {
  String brandID;
  AllProductScreen(this.brandID);
  @override
  AllProductScreenState createState() => AllProductScreenState(brandID);
}

class AllProductScreenState extends State<AllProductScreen> {
  String brandID;
  AllProductScreenState(this.brandID);
  List<dynamic> productList=[];
  String productCount='0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                                brandID=='NA'?
                                'All Products':'Brand Products',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: MyColor.textBlueColor,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Gilroy'),
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
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>ProductDetail(productList[index]['id'].toString(),productList[index]['productName'],productList[index]['productQuantity'].toString()+' '+productList[index]['productPerimeter'],productList[index]['productPrice'].toString(),Constants.imageBaseUrl+productList[index]['productImage'],productList[index]['productDescription'],productList[index]['subCategoryId'].toString())));

                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        child: FavouriteListItem(productList[index]['productImage'],productList[index]['productName'],productList[index]['productPrice'].toString(),productList[index]['productPerimeter'],productList[index]['productQuantity'].toString()),
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
    checkInternetAPIcall();



  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
     if(brandID=='NA')
       {
         fetchProductsNormal();
       }
     else{
       fetchBrandProducts();
     }
    } else {
      Toast.show('No Internet found !! ', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.lightBlue,);

    }
  }

  fetchProductsNormal() async {
    String message = '';
    APIDialog.showAlertDialog(context, 'Please wait...');
    try {
      http.Response response;
      response = await http.get(
        Constants.appBaseUrl+'product/api/allProductCategoryData',
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      setState(() {
        productList=fetchResponse['data']['product'];
        productCount=productList.length.toString();
      });
      Navigator.pop(context);
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.pop(context);
    }
  }
  fetchBrandProducts() async {
    var _fromData = {
      'brandId': brandID,
    };
    print(_fromData);
    ApiBaseHelper helper=new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Please wait...');
    var response=await helper.postAPIFormData('product/api/brandProducts', context,_fromData);
    Navigator.pop(context);
    setState(() {
      productList=response['data'];
      productCount=productList.length.toString();
    });
    print(response);



  }
   addProduct(int productId) async {
    var _fromData = {
      'product_id': productId.toString(),
      'product_qty': 1,
    };

    print(_fromData);
    ApiBaseHelper helper=new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Adding to cart...');
    var response=await helper.postAPIFormData('product/api/cart/add', context,_fromData);
    Navigator.pop(context);
    if(response['status']=='success')
    {
      Toast.show('Product added to cart !!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: MyColor.themeColor);
    }
    else
    {
      Toast.show(response['message'], context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: MyColor.noInternetColor);
    }
    print(response);
  }

}
