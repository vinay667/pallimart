import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/callbacks/type_click_callback.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/widgets/account_item.dart';
import 'package:pallimart/widgets/appbar_title.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    implements TypeClickListener {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColor.whiteColor,
      body: ListView(
        padding: EdgeInsets.only(
          bottom: 16,
        ),
        children: <Widget>[
          SizedBox(height: 24,),
          Stack(children: <Widget>[
            Image.asset(
              'images/ellipse_account.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              height: screenSize.height / 5,
            ),
            Container(
                height: screenSize.height / 5 + 32,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 56,
                          ),
                          AppbarTitleText(
                            title: 'My Account',
                            color: MyColor.whiteColor,
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              child: Image.asset(
                                "images/icon_account_delete.png",
                              ))
                        ]),
                    Expanded(
                      child: Container(),
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: MyColor.whiteColor,
                      child: CircleAvatar(
                        radius: 38,
                        backgroundColor: MyColor.whiteColor,
                        backgroundImage: AssetImage('images/grocery.png'),
                      ),
                    ),
                  ],
                ))
          ]),
          SizedBox(
            height: 8,
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                "Angelina Mark",
                style: TextStyle(
                    fontSize: 18,
                    color: MyColor.homeTitleColor,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w700),
              )),
          SizedBox(
            height: 8,
          ),
          Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                elevation: 8,
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        AccountItem(
                          callback: this,
                          image: 'images/icon_order.png',
                          title: 'Order',
                          subTitle: 'Check your order status',
                        ),
                        Divider(),
                        AccountItem(
                          callback: this,
                          image: 'images/icon_profile.png',
                          title: 'Profile Detail',
                          subTitle: 'Change your profile detail & password',
                        ),
                      ],
                    )),
              ),
              Card(
                elevation: 8,
                margin: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        AccountItem(
                          callback: this,
                          image: 'images/icon_wallet.png',
                          title: 'Your Credit',
                          subTitle: 'Manage all your refunds & gift cards',
                        ),
                        Divider(),
                        AccountItem(
                          callback: this,
                          image: 'images/icon_card.png',
                          title: 'Saved Cards',
                          subTitle: 'Save your cards for faster checkout',
                        ),
                        Divider(),
                        AccountItem(
                          callback: this,
                          image: 'images/icon_coupon.png',
                          title: 'Coupons',
                          subTitle: 'Manage coupons for additional Discount',
                        ),
                      ],
                    )),
              ),
              Card(
                elevation: 8,
                margin: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        AccountItem(
                          callback: this,
                          image: 'images/icon_address.png',
                          title: 'Address',
                          subTitle: 'Save address for hassle free checkout',
                        ),
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void onTypeClickListener(String type) {
    switch (type) {
      case 'Profile Detail':
        Navigator.pushNamed(context, '/profile');
        break;
      case 'Saved Cards':
        Navigator.pushNamed(context, '/add_card');
        break;
      case 'Address':
        Navigator.pushNamed(context, '/add_address');
        break;
      case 'Coupons':
        Navigator.pushNamed(context, '/coupon');
        break;
      case 'Order':
        Navigator.pushNamed(context, '/orders');
        break;


    }
  }
}
