import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/constants.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/widgets/category_list_item.dart';
import 'package:toast/toast.dart';
List<CategoryModel> myList = List<CategoryModel>();

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<dynamic> productList=[];
  List<dynamic> categoryList=[];
  @override
  void initState() {
    super.initState();
    checkInternetAPIcall();
    if (myList.length == 11) return;
    myList.add(CategoryModel("Grocery", "images/grocery.png"));
    myList.add(CategoryModel("Mobile", "images/icon_mobile.png"));
    myList.add(CategoryModel("Fashion", "images/icon_fashion.png"));
    myList.add(CategoryModel("appliances", "images/icon_appliance.png"));
    myList.add(CategoryModel("Beauty", "images/icon_beauty.png"));
    myList.add(CategoryModel("home", "images/icon_furniture.png"));
    myList.add(CategoryModel("Jewelry", "images/icon_jewelry.png"));
    myList.add(CategoryModel("Watches", "images/icon_watches.png"));
    myList.add(CategoryModel("Footwear", "images/icon_footwear.png"));
    myList.add(CategoryModel("Bags", "images/icon_bag.png"));
    myList.add(CategoryModel("Kids wear", "images/icon_kids_wear.png"));




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                'Categories (Total '+ categoryList.length.toString()+')',
                style: TextStyle(
                    color: MyColor.searchTotalTextColor,
                    fontSize: 15,
                    fontFamily: 'Geomanist'),
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
                  margin: EdgeInsets.only(right: 15),
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                      childAspectRatio: 2/2
                  ),
                      itemCount: categoryList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context,int position)
                      {

                        return InkWell(
                            onTap: () => Navigator.pushNamed(context, "/subc"),
                            child: Container(
                              width: MediaQuery.of(context).size.width/4.3,
                              child: Card(
                                color: Colors.white,
                                margin: EdgeInsets.only(bottom: 5, left: 4, right: 4, top:5),
                                elevation: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FadeInImage.assetNetwork(
                                      height: 50,
                                      placeholder: 'images/app_logo.png',
                                      image: Constants.imageBaseUrl,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      categoryList[position]['categoryName'],
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
                            ));

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
    APIDialog.showAlertDialog(context, 'Please wait...');
    try {
      http.Response response;
      response = await http.get(
        Constants.appBaseUrl+'product/api/allProductCategoryData',
      );
      Map<String, dynamic> fetchResponse = json.decode(response.body);
      print(fetchResponse);
      setState(() {
       // productList=fetchResponse['data']['product'];
        categoryList=fetchResponse['data']['category'];
      });
      Navigator.pop(context);
    } catch (errorMessage) {
      message = errorMessage.toString();
      print(message);
      Navigator.pop(context);
    }
  }
}
