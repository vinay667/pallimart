import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/screens/product_detail.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/constants.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/widgets/favourite_list_item.dart';
import 'package:toast/toast.dart';

class FavScreen extends StatefulWidget {
  FavState createState() => FavState();
}

class FavState extends State<FavScreen> {
  List<dynamic> productList=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Products",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: GridView.builder(
              padding: EdgeInsets.only(left: 8, right: 8,top: 15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 16,
                  childAspectRatio: .8),
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>ProductDetail(productList[index]['id'].toString(),productList[index]['products']['productName'],productList[index]['products']['productQuantity'].toString()+' '+productList[index]['products']['productPerimeter'],productList[index]['products']['productPrice'].toString(),Constants.imageBaseUrl+productList[index]['products']['productImage'],productList[index]['products']['productDescription'],productList[index]['products']['subCategoryId'].toString())));
                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        child: FavouriteListItem(productList[index]['products']['productImage'],productList[index]['products']['productName'],productList[index]['products']['productPrice'].toString(),productList[index]['products']['productPerimeter'],productList[index]['products']['productQuantity'].toString())
                    ));
              })),
    );
  }



  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      getMyOrders();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
  }


   getMyOrders() async {
    ApiBaseHelper helper=new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Please wait...');
    var response=await helper.getWithToken('product/api/product/favourite/list', context);
    Navigator.pop(context);
    setState(() {
      productList=response['data'];
    });

    if(productList.length==0)
      {
        Toast.show('No Fav Items found !!!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.black);
      }
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
}