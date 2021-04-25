import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/callbacks/type_click_callback.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/screens/add_address_screen.dart';
import 'package:pallimart/screens/all_address_screen.dart';
import 'package:pallimart/screens/my_orders_screen.dart';
import 'package:pallimart/screens/profile_screen.dart';
import 'package:pallimart/utils/login_Dialog.dart';
import 'package:pallimart/widgets/account_item.dart';
import 'package:pallimart/widgets/appbar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}
class _AccountScreenState extends State<AccountScreen>
    implements TypeClickListener {
 String username='';

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
                   /* CircleAvatar(
                      radius: 40,
                      backgroundColor: MyColor.whiteColor,
                      child: CircleAvatar(
                        radius: 38,
                        backgroundColor: MyColor.whiteColor,
                        backgroundImage: AssetImage('images/grocery.png'),
                      ),
                    ),*/
                  ],
                ))
          ]),


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
                        InkWell(
                          onTap:(){


                            if(UserModel.accessToken=='notLogin')
                            {
                              LoginDialog.showLogInDialog(context, 'Login to view Orders !!');
                            }
                            else{
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrdersScreen()));

                            }




                },
                          child:  AccountItem(
                            image: 'images/icon_order.png',
                            title: 'Order',
                            subTitle: 'Check your order status',
                          ),
                        ),
                        Divider(),

                        InkWell(
                          onTap: (){

                            if(UserModel.accessToken=='notLogin')
                              {
                                LoginDialog.showLogInDialog(context, 'Login to view Profile !!');
                              }
                            else{
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));

                            }



                          },
                          child:   AccountItem(
                            image: 'images/icon_profile.png',
                            title: 'Profile Detail',
                            subTitle: 'Change your profile detail & password',
                          ),
                        )
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
                          image: 'images/icon_wallet.png',
                          title: 'Your Credit',
                          subTitle: 'Manage all your refunds & gift cards',
                        ),
                        Divider(),
                        AccountItem(

                          image: 'images/icon_card.png',
                          title: 'Saved Cards',
                          subTitle: 'Save your cards for faster checkout',
                        ),
                       // Divider(),
                      /*  AccountItem(

                          image: 'images/icon_coupon.png',
                          title: 'Coupons',
                          subTitle: 'Manage coupons for additional Discount',
                        ),*/
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

                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AllAddressScreen()));
                          },
                          child:   AccountItem(
                            image: 'images/icon_address.png',
                            title: 'Address',
                            subTitle: 'Save address for hassle free checkout',
                          ),
                        )
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
        break;
      case 'Saved Cards':
        Navigator.pushNamed(context, '/add_card');
        break;
      case 'Address':
        break;
      case 'Coupons':
        Navigator.pushNamed(context, '/coupon');
        break;
      case 'Order':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrdersScreen()));
        break;


    }
  }

  setUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('name') ?? '';
     // userEmail = prefs.getString('email') ?? '';
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserData();
  }
}
