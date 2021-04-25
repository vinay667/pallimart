
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/widgets/custom_text_payment.dart';
import 'package:pallimart/screens/order_placed_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class PaymentScreen extends StatefulWidget {
  int price;
  PaymentScreen(this.price);
  PaymentState createState() => PaymentState();
}

class PaymentState extends State<PaymentScreen> {
  Razorpay _razorpay;
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
                      padding: EdgeInsets.only(left: 15, top: 15),
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
                  SizedBox(height: 10),

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

                 openCheckout();



                      },
                      child: Card(
                        elevation: 10,
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
                            margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 25),
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

                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    print(widget.price);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    String price=widget.price.toString()+'00';
    var options = {
      'key': 'rzp_test_at76KNyCpjHuk1',
      'amount': price,
      'name': 'Vinay',
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Toast.show("SUCCESS: " + response.paymentId, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.green,);
    placeOrder();

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Toast.show("ERROR: " + response.code.toString() + " - " + response.message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM,backgroundColor: Colors.red,);


  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Toast.show("EXTERNAL_WALLET: " + response.walletName, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.red,);

  }
  placeOrder() async {
    var _fromData = {
      'paymentType': 'cashOnDelivery',
    };
    ApiBaseHelper helper=new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Placing Order...');
    try{
      var response=await helper.postAPIFormData('product/api/order/save', context,_fromData);
      Navigator.pop(context);
      Toast.show('Order Placed Successfully !! !!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.green);
      print(response.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OrderPlacedScreen()),
          ModalRoute.withName("/home"));
    }
    catch (errorMessage) {
      String message = errorMessage.toString();
      print(message);
      Navigator.pop(context);
      Toast.show('Order Placed Successfully !! !!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: Colors.green);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OrderPlacedScreen()),
          ModalRoute.withName("/home"));
    }

  }

/*  postData()async{
    Map<String,dynamic> _fromData = {
      'paymentType': 'cashOnDelivery',
    };
    var dio = Dio();
    try {
      //http://pallimart.com/product/api/order/save
      //http://www.pallimart.com/product/api/order/save
      var formData = new FormData.fromMap(_fromData);
      dio.options.headers["access-token"]=UserModel.accessToken;
      print(UserModel.accessToken);
      print(_fromData);
      var response = await dio.post('http://pallimart.com/product/api/order/save', data: formData);
      var responseBody = response.data;
      print(responseBody.toString()+'egwergw');
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }*/





}
