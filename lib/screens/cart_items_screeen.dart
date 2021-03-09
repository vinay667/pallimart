
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/callbacks/button_click_callback.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/screens/all_address_screen.dart';
import 'package:pallimart/screens/select_address_screen.dart';
import 'package:pallimart/utils/constants.dart';

import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/widgets/appbar_widget.dart';
import 'package:pallimart/widgets/button_widget.dart';
import 'package:pallimart/widgets/text_widget.dart';
import 'package:toast/toast.dart';

class CartItemsScreen extends StatefulWidget {
  CartItemsState createState() => CartItemsState();
}

class CartItemsState extends State<CartItemsScreen>
    implements ButtonClickListener {

  List<dynamic> cartItems=[];
  String cartCount='0',cartSubTotal='0',cartTotal='0';
  String imageURI='',emptyString='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        context: context,
       // clickListener: this,
        counter: UserModel.accessToken=='notLogin'?'0':UserModel.cartCount,

        isBack: true,
        type: "shopping",
        title: "Shopping Cart",

      ),
      body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: cartItems.length!=0?ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Total Cart Products ('+cartCount.toString()+')',
                        style: TextStyle(
                            fontFamily: 'Geomanist',
                            fontSize: 15,
                            color: MyColor.cartTextColor),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: cartItems.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int position) {
                          return Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 5),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.3)),
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: <Widget>[
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                        BorderRadius.circular(8.3)),
                                        child: FadeInImage.assetNetwork(
                                          height: 100,
                                          width: 100,
                                          placeholder: 'images/app_logo.png',
                                          image: Constants.imageBaseUrl+cartItems[position]['product']['productImage'],
                                        ), /*Image.network(
                                          'https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg',
                                          height: 128.7,
                                          width: 100.3,
                                          fit: BoxFit.fill,
                                        ),*/
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  cartItems[position]['product']['productName'],
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Gilroy',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: MyColor
                                                          .homeItemTitleColor),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                             GestureDetector(
                                               onTap: (){
                                                 showRemoveProductDialog(context,cartItems[position]['product']['id']);
                                               },
                                               child:  Image.asset(
                                                 'images/cross.png',
                                                 width: 17,
                                                 height: 17,
                                               ),

                                             )
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 2),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 0),
                                                  child: Text(
                                                    'Rs. '+cartItems[position]['product']['productPrice'].toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: MyColor
                                                          .homeItemTitleColor,
                                                      fontFamily: 'Gilroy',
                                                    ),
                                                  ),
                                                ),
                                              /*  Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 8),
                                                  child: Text(
                                                    '\$2500',
                                                    style: TextStyle(
                                                        fontSize: 7.7,
                                                        color: MyColor
                                                            .homeItemSubTitleColor,
                                                        fontFamily: 'Gilroy',
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                )*/
                                              ],
                                            ),
                                          ),

                                          Row(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(top: 10),
                                                child:Container(
                                                  width: 58.3,
                                                  height: 17.7,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: MyColor.lightGrey,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                                  ),
                                                  child: Text(
                                                    cartItems[position]['productTotalQty'].toString()+' '+cartItems[position]['product']['productPerimeter'],
                                                    style: TextStyle(
                                                        fontSize: 9.3,
                                                        fontFamily: 'Gilroy',
                                                        color: MyColor
                                                            .homeItemTitleColor,
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(width: 20),

                                              Container(
                                                width: 94,
                                                height: 32,
                                                margin: EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(
                                                        color:
                                                        MyColor.themeColor,
                                                        width: 2)),
                                                child: Row(
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
                                                      },
                                                      child: Container(
                                                          width: 30,
                                                          child: Center(
                                                              child: Image.asset(
                                                                'images/minus.png',
                                                                width: 11,
                                                                height: 15,
                                                                color: Colors.black,
                                                              ))),
                                                    ),
                                                    Container(
                                                        width: 30,
                                                        height: 30,
                                                        color:
                                                        MyColor.themeColor,
                                                        child: Center(
                                                            child: Text( cartItems[position]['productTotalQty'].toString(),style: TextStyle(
                                                              fontSize: 15,color: Colors.white,fontFamily: 'Gilroy',fontWeight: FontWeight.bold
                                                            ),)
                                                        )),
                                                    GestureDetector(
                                                      onTap: () {

                                                        addProduct(
                                                            cartItems[
                                                            position]
                                                            ['product_id']);

                                                      },
                                                      child: Container(
                                                          width: 30,
                                                          child: Center(
                                                              child: Image.asset(
                                                                'images/add.png',
                                                                width: 12,
                                                                height: 12,
                                                              ))),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),

                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ));
                        }),
                    SizedBox(
                      height: 20,
                    ),
                   /* Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: DottedBorder(
                        color: Colors.black.withOpacity(0.4),
                        strokeWidth: 0.9,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(8.3),
                        padding: EdgeInsets.all(6),
                        child: Container(
                          height: 83,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  'Coupons:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'Gilroy'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 5),
                                child: Container(
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 12,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'GilroySemibold'),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 10.0, bottom: 15),
                                      border: InputBorder.none,
                                      hintText: 'Apply Coupon CODE',
                                      hintStyle: TextStyle(
                                          color: MyColor.grey,
                                          fontSize: 12,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'GilroySemibold'),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black54, width: 0.2),
                                    color: Colors.white,
                                  ),
                                  height: 34.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),*/
                    Padding(
                        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Divider(
                          color: MyColor.grey,
                        )),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'PRICE DETAIL ('+cartCount.toString()+') items',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Gilroy',
                            color: MyColor.homeItemTitleColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Cart Sub Total',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Gilroy',
                              color: MyColor.homeItemTitleColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Text(
                            'Rs. '+cartSubTotal.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Gilroy',
                              color: MyColor.homeItemTitleColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Divider(
                          color: MyColor.grey,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'TOTAL',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Gilroy',
                              color: Colors.black,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Text(
                            'Rs. '+cartTotal.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 5, left: 15, right: 15, bottom: 10),
                        child: Divider(
                          color: MyColor.grey,
                        )),
                  ],
                ):Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

//'images/cart_empty.png'
                      Image.asset(imageURI,width: 110,height: 110,),


//'No items in your cart !!'
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: TextWidget(
                            emptyString, Colors.black87, 18),
                      ),


                      SizedBox(height: 30)





                    ],
                  ),
                )
              ),
             cartItems.length!=0? MyButton(callback: this, title: "Continue"):Container()





             // MyButton(callback: this, title: "Continue")
            ],
          )),
    );
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

      fetchCartData();
    } else {
      Toast.show(response['message'], context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: MyColor.noInternetColor);
    }
    print(response);
  }
   fetchCartData() async {
    ApiBaseHelper helper=new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Fetching Cart');
    var response=await helper.getWithToken('product/api/cart/data', context);
    Navigator.pop(context);
    print(response);
    setState(() {
      cartItems=response['data']['customerCart'];
      cartCount=response['data']['countCart'].toString();
      cartSubTotal=response['data']['cartSubtotal'].toString();
      cartTotal=response['data']['cartTotal'].toString();
    });
    if(cartItems.length==0)
      {
        setState(() {
          imageURI='images/cart_empty.png';
          emptyString='No items in your cart !!';
        });

        Toast.show('No Products found !!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: MyColor.noInternetColor);
      }
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      fetchCartData();
    } else {
      Toast.show('No Internet connection !!!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: MyColor.noInternetColor);

    }
  }
  showRemoveProductDialog(BuildContext context,int productId) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {

removeProduct(productId);



      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Remove Product ?"),
      content: Text("Are you sure you want to remove this Product ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  removeProduct(int productId) async {
    var _fromData = {
      'product_id': productId.toString(),
    };
    ApiBaseHelper helper=new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Removing Product...');
    var response=await helper.postAPIFormData('product/api/cart/remove', context,_fromData);
    Navigator.pop(context);
    if(response['status']=='success')
    {
      Toast.show('Product removed successfully !! !!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: MyColor.themeColor);
      Navigator.pop(context);
      fetchCartData();
    }
    else
    {
      Navigator.pop(context);
      Toast.show(response['message'], context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: MyColor.noInternetColor);
    }
    print(response);
  }

  @override
  void onButtonClickListener(int id) {

    Navigator.push(context, CupertinoPageRoute(builder: (context) =>SelectAddressScreen(int.parse(cartTotal))));




  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   checkInternetAPIcall();


  }
}
