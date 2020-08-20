
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/widgets/custom_text_payment.dart';
import 'package:pallimart/screens/order_placed_screen.dart';
import 'package:toast/toast.dart';

class PaymentScreen extends StatefulWidget {
  PaymentState createState() => PaymentState();
}

class PaymentState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
                height: 60,
                width: double.infinity,
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left:15),
                        child: Image.asset('images/back_icon.png',
                            width: 19.3, height: 9.3),
                      ),
                    ),
                    Expanded(
                      child: Center(
                          child: CustomTextPayment('Payment')),
                    ),
                  ],
                )),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 5),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: CustomTextPayment('Payment Modes'),
                  ),
                  Container(
                      height: 193,
                      child: ListView.builder(
                          itemCount: 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 20),
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(23.3)),
                                child: Container(
                                  height: 123,
                                  width: 154,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons.check_circle,
                                                color: MyColor.greenColor,
                                              ),
                                            ),
                                          )),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'PAY BY CASH',
                                          style: TextStyle(
                                              color: MyColor.cardNameColor,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding:
                                        EdgeInsets.only(left: 10, top: 8),
                                        child: Text(
                                          'Available',
                                          style: TextStyle(
                                              color: MyColor.themeColor,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding:
                                        EdgeInsets.only(left: 10, top: 5),
                                        child: Text(
                                          'Pay to our delivery executive',
                                          style: TextStyle(
                                              color: MyColor.addAddressFont,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 15),
                                            child: Image.asset(
                                              'images/cash_ion.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Card(
                                              color: MyColor.textBlueColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20)),
                                              child: Container(
                                                  width: 45,
                                                  height: 20,
                                                  child: Center(
                                                    child: Text(
                                                      'Edit',
                                                      style: TextStyle(
                                                          fontFamily: 'Gilroy',
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                                  )),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry \'s standard dummytext ever since the 1500s.',
                      style: (TextStyle(
                          color: MyColor.dummyPaymentTextColor,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.18,
                          decoration: TextDecoration.none,
                          fontSize: 13)),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 15, top: 35),
                      child: CustomTextPayment('Promo Code')),

                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: MyColor.themeColor,width: 1)


                    ),
                    height: 45,
                    child:  TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          fontFamily: 'GilroySemibold'),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10.0,bottom: 5),
                        border: InputBorder.none,
                        hintText: 'Enter Coupon Code ',
                        hintStyle: TextStyle(
                            color: MyColor.greyDivider22,
                            fontSize: 12,
                            decoration: TextDecoration.none,
                            fontFamily: 'GilroySemibold'),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  Container(
                    margin: EdgeInsets.only(left: 15,right: 200),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(right: 0, left:0),
                          child: Center(
                            child: Text(
                              'APPLY COUPON',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'GilroySemibold'),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: <Color>[
                              MyColor.themeColor,
                              MyColor.gradientEnd
                            ],
                          ),
                          color: Colors.white,
                        ),
                        height: 40,
                      ),
                    ),


                  ),



                  SizedBox(height: 50,),


                  GestureDetector(
                      onTap: (){


                        placeOrder();
                        //Navigator.push(context, CupertinoPageRoute(builder: (context)=>PaymentScreen()));



                      },
                      child: Card(
                        elevation: 30,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                        child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/roundedRectangle.png"),
                                  fit: BoxFit.fill),
                            ),
                            child: Text(
                              "Place Order and Checkout",
                              style: TextStyle(
                                  color: MyColor.whiteColor,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.w600),
                            ) // button text
                        ),
                      )

                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  placeOrder() async {
    ApiBaseHelper helper=new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Placing Order...');
    var response=await helper.postAPI('product/api/order/save?paymentType=cashOndelivery', context);
    Navigator.pop(context);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OrderPlacedScreen()),
        ModalRoute.withName("/home"));
    Toast.show('Order Placed Successfully !! !!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.green);
  }





}