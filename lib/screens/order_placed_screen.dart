import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/widgets/custom_toolbar.dart';
import 'package:pallimart/widgets/text_widget.dart';

class OrderPlacedScreen extends StatefulWidget {
  OrderPlacedState createState() => OrderPlacedState();
}

class OrderPlacedState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 120),
            Image.asset('images/check.png', width: 100, height: 100),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Your Order has been placed successfully.\n Thankyou !',
                style: TextStyle(
                    fontSize: 17,
                    color: MyColor.textBlueColor,
                    fontFamily: 'GilroySemibold'),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/bottom');
              },
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 30),
                child: Card(
                  color: MyColor.themeColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Container(
                    height: 40,
                    child: Center(
                        child: TextWidget('Back to Home', Colors.white, 14)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
