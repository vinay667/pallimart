import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:toast/toast.dart';

class MyOrdersScreen extends StatefulWidget {
  MyOrdersState createState() => MyOrdersState();
}

class MyOrdersState extends State<MyOrdersScreen> {
  List<dynamic> orderList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "My Orders",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: orderList.length,
              itemBuilder: (BuildContext context, int position) {
                return GestureDetector(
                  onTap: () {
                    //Navigator.pushNamed(context, '/orderdetail');
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 5,
                            right: 10,
                          ),
                          child: Text(
                            'Order no.: 112346750'+orderList[position]['id'].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: MyColor.cartTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gilroy',
                                letterSpacing: -0.24),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.3),
                              ),
                              child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 10, bottom: 10),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8.3),
                                              child: Image.asset(
                                                'images/logo.png',
                                                height: 125.7,
                                                width: 100.3,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            left: 10, top: 5),
                                                        child: Text(
                                                          orderList[position]['productName'],
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color:
                                                              MyColor.greyDark,
                                                              fontSize: 16,
                                                              fontWeight:
                                                              FontWeight.w700,
                                                              fontFamily: 'Gilroy',
                                                              letterSpacing: -0.24),
                                                        ),
                                                      ),
                                                      flex: 8,
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsets.only(top: 5),
                                                        child: Image.asset(
                                                          'images/right_arrow_black.png',
                                                          width: 7,
                                                          height: 12,
                                                        ),
                                                      ),
                                                      flex: 1,
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10, top: 3),
                                                  child: Text(
                                                    'by Alok Departmental Store ',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color:
                                                      MyColor.listProductItems,
                                                      fontSize: 13,
                                                      fontFamily: 'Gilroy',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 3, left: 10),
                                                      child: Text(
                                                        'Rs'+orderList[position]['productPrice'].toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: MyColor
                                                                .listProductName,
                                                            fontFamily: 'Gilroy',
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),
                                                    ),
                                                   /* Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3, top: 6),
                                                      child: Text(
                                                        'Rs2500',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: MyColor
                                                              .listProductItems,
                                                          fontFamily: 'Gilroy',
                                                          decoration: TextDecoration
                                                              .lineThrough,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                        ),
                                                      ),
                                                    )*/
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10, top: 8),
                                                  child: Row(
                                                    children: <Widget>[

                                                      Container(
                                                        width: 58.3,
                                                        height: 17.7,
                                                        decoration: BoxDecoration(
                                                          color: MyColor.lightGrey,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Qty '+orderList[position]['productSalesQuantity'].toString(),
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontFamily:
                                                                'Gilroy',
                                                                color: MyColor
                                                                    .listProductName,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10, top: 12),
                                                  child: Text(
                                                    'Delivered (Mar 19,2020)',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                        MyColor.txtLightGreen,
                                                        fontFamily: 'Gilroy',
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 1,
                                        color: MyColor.greyDivider22,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Share Rating:',
                                              style: TextStyle(
                                                  color: MyColor.greyDark,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Gilroy',
                                                  letterSpacing: -0.24),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Image.asset(
                                            'images/rating_empty.png',
                                            width: 16,
                                            height: 16,
                                          ),
                                          SizedBox(width: 3),
                                          Image.asset(
                                            'images/rating_empty.png',
                                            width: 16,
                                            height: 16,
                                          ),
                                          SizedBox(width: 3),
                                          Image.asset(
                                            'images/rating_empty.png',
                                            width: 16,
                                            height: 16,
                                          ),
                                          SizedBox(width: 3),
                                          Image.asset(
                                            'images/rating_empty.png',
                                            width: 16,
                                            height: 16,
                                          ),
                                          SizedBox(width: 3),
                                          Image.asset(
                                            'images/rating_empty.png',
                                            width: 16,
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  )),
                            )),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                );
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
    var response=await helper.getWithToken('product/api/order/history', context);
    Navigator.pop(context);
    setState(() {
      orderList=response['data'];
    });

    if(orderList.length==0)
      {
        Toast.show('No orders found !!!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: MyColor.noInternetColor);

      }


    print(response);
  }



}