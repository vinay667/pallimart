import 'package:flutter/material.dart';
import 'package:pallimart/callbacks/button_click_callback.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/screens/cart_items_screeen.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/constants.dart';
import 'package:pallimart/utils/constants2.dart';
import 'package:pallimart/utils/login_Dialog.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/widgets/appbar_widget.dart';
import 'package:pallimart/widgets/button_widget.dart';
import 'package:toast/toast.dart';

class ProductDetail extends StatefulWidget {
  String productID, name, quantity, price, productImage, productDes, subCatID;

  ProductDetail(this.productID, this.name, this.quantity, this.price,
      this.productImage, this.productDes, this.subCatID);

  @override
  _ProductDetailState createState() => _ProductDetailState(
      productID, name, quantity, price, productImage, productDes, subCatID);
}

class _ProductDetailState extends State<ProductDetail>
    implements ButtonClickListener {
  List<dynamic> productList = [];
  String productID, name, quantity, price, productImage, productDes, subCatId;

  _ProductDetailState(this.productID, this.name, this.quantity, this.price,
      this.productImage, this.productDes, this.subCatId);

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarWidget(
          context: context,
          clickListener: this,
          counter: UserModel.accessToken=='notLogin'?'0':UserModel.cartCount,

          isBack: true,
          type: "home",
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                      height: 240,
                      child: PageView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: _controller,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.white,
                              margin: EdgeInsets.only(
                                  bottom: 80, left: 16, right: 16),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Image.network(
                                    productImage,
                                  )),
                            );
                          })),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /* Padding(
                        padding: EdgeInsets.only(left: 42, bottom: 8),
                        child: SmoothPageIndicator(
                          controller: _controller, // PageController
                          count: 4,
                          effect: WormEffect(
                            activeDotColor: MyColor.dotActiveColor,
                            dotColor: MyColor.dotInactiveColor,
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                        ), // your preferred effect
                      ),*/
                      Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 8,
                          margin:
                              EdgeInsets.only(bottom: 12, left: 32, right: 32),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                      color: MyColor.homeItemTitleColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Gilroy'),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          quantity,
                                          style: TextStyle(
                                              color:
                                                  MyColor.homeItemSubTitleColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Gilroy'),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'Rs. ' + price,
                                              style: TextStyle(
                                                  color: MyColor
                                                      .homeItemTitleColor,
                                                  fontSize: 10.7,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Gilroy'),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "(Inclusive of all taxes)",
                                              style: TextStyle(
                                                  color: MyColor
                                                      .detailInclusiveText,
                                                  fontSize: 7.8,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),

                                    GestureDetector(
                                      onTap: (){
                                        addtoFavourite();
                                      },
                                      child:  Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Image.asset('images/ellipse_like.png'),
                                          Image.asset(
                                            'images/icon_fav.png',
                                            color: MyColor.whiteColor,
                                          )
                                        ],
                                      ),
                                    )


                                  ],
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              TitleText("Product Detail"),
              SizedBox(
                height: 12,
              ),
              Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    productDes,
                    style: TextStyle(
                        color: MyColor.detailText,
                        fontSize: 9.3,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: 12,
              ),

              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/roundedRectangleDoted.png"),
                        fit: BoxFit.fill)),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 12, right: 12, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                   /* Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TitleText('Check Delivery'),
                        Text(
                          '(Pay on delivery might be available)',
                          style: TextStyle(
                              color: MyColor.detailPrice,
                              fontSize: 7.7,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.all(12),
                        child: TextField(
                            expands: false,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "ENTER  PIN CODE",
                                hintStyle: TextStyle(
                                    color: MyColor.homeItemSubTitleColor),
                                contentPadding: const EdgeInsets.only(
                                    left: 12, bottom: 1.0, top: 1.0, right: 12),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    )),
                                fillColor: MyColor.whiteColor),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 9.3,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                            textInputAction: TextInputAction.search,
                            maxLines: 1,
                            onSubmitted: (term) {})),*/
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/roundedRectangle.png'),
                  fit: BoxFit.fill,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Easy 30 days return and exchange',
                      style: TextStyle(
                          color: MyColor.whiteColor,
                          fontSize: 10.8,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Choose to return or exchange for a different size (if available) with in 30 days',
                      style: TextStyle(
                          color: MyColor.detailPolicyTextColor,
                          fontSize: 9.3,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Similar items',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productList.length,
                      padding: EdgeInsets.only(left: 12, right: 12),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                        productList[index]['id'].toString(),
                                        productList[index]['productName'],
                                        productList[index]['productQuantity']
                                                .toString() +
                                            ' ' +
                                            productList[index]
                                                ['productPerimeter'],
                                        productList[index]['productPrice']
                                            .toString(),
                                        Constants.imageBaseUrl +
                                            productList[index]['productImage'],
                                        productList[index]
                                            ['productDescription'],
                                        productList[index]['subCategoryId']
                                            .toString())));
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * .45,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  Card(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(
                                        bottom: 42, left: 4, right: 4),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 12,
                                              right: 12,
                                              top: 5,
                                              bottom: 25),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            child: FadeInImage.assetNetwork(
                                              height: 140.0,
                                              fit: BoxFit.fill,
                                              placeholder:
                                                  'images/app_logo.png',
                                              image: Constants.imageBaseUrl +
                                                  productList[index]
                                                      ['productImage'],
                                            ),
                                          ),
                                        ),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 5,
                                      margin: EdgeInsets.only(
                                          bottom: 12, left: 12, right: 12),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                              productList[index]['productName'],
                                              style: TextStyle(
                                                  color: MyColor
                                                      .homeItemTitleColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Gilroy'),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      productList[index][
                                                                  'productQuantity']
                                                              .toString() +
                                                          ' ' +
                                                          productList[index][
                                                              'productPerimeter'],
                                                      style: TextStyle(
                                                          color: MyColor
                                                              .homeItemSubTitleColor,
                                                          fontSize: 9.3,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Gilroy'),
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
                                                              fontSize: 10.7,
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
                                                    if(UserModel.accessToken=='notLogin')
                                                    {
                                                      LoginDialog.showLogInDialog(context,'Please Login to add a Product !!');


                                                    }
                                                    else{
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
                      })),
              SizedBox(
                height: 8,
              ),
              //HomeListView(),
            ],
          )),
          MyButton(callback: this, title: "Add to Cart"),
        ]));
  }

  addProduct(String productId) async {
    var _fromData = {
      'product_id': productId,
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

  fetchProducts() async {
    var _fromData = {
      'subCategoryId': subCatId,
    };
    print(_fromData);
    ApiBaseHelper helper = new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Please wait...');
    var response = await helper.postAPIFormData(
        'product/api/subCategoryProducts', context, _fromData);
    Navigator.pop(context);
    setState(() {
      productList = response['data'];
    });
    print(response);
  }
  addtoFavourite() async {
    var _fromData = {
      'productId': productID,
    };
    print(_fromData);
    ApiBaseHelper helper = new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Please wait...');
    var response = await helper.postAPIFormData(
        'product/api/add/favourite/product', context, _fromData);
    Navigator.pop(context);
    if(response['status'].toString()=='success')
    {
      Toast.show('Add to favourite list successfully !!', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.black);
     // Navigator.pop(context);
      print(response.toString());
    }




    print(response);
  }
  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      fetchProducts();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
  }

  @override
  void onButtonClickListener(int id) {
    if (id == Constants2.SEARCH_CLICK_ID)
      Navigator.pushNamed(context, '/search');
    else if (id == Constants2.BUTTON_CLICK_ID) {
      if(UserModel.accessToken=='notLogin')
      {
        LoginDialog.showLogInDialog(context,'Please Login to add a Product !!');


      }



      else{
        addProduct(productID);
      }

    }


    else if (id == Constants2.CART_ID) {
      if(UserModel.accessToken=='notLogin')
      {
        LoginDialog.showLogInDialog(context,'Please Login to view Cart !!');


      }



      else{

        Navigator.push(context, MaterialPageRoute(builder: (context)=>CartItemsScreen()));
      }

    }
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
        title,
        style: TextStyle(
            color: MyColor.detailTitleText,
            fontSize: 10.8,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
