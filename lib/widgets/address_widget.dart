
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';

import 'gradient_border_button.dart';
import 'gradient_text.dart';
class AddressWidget extends StatelessWidget {
  String name,phone,email,address;
  int position,index;
  AddressWidget(this.name,this.phone,this.email,this.address,this.position,this.index);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.3)),
      child: Container(

        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 16,
                        color: MyColor.greyDark,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.24),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 15),
                  child:index==position?Image.asset('images/check_ic.png',width: 20,height: 20,):Container()
                  
                  
                  /*Container(
                    width: 73,
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyColor.boxAddressColor,
                    ),
                    child: Center(
                      child: Text(
                        'Office',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),*/
                )
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Text(
                address,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 0.27,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w500,
                    color: MyColor.greyDark),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15, top: 2),
              child: Text(
                email,
                style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 0.27,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w500,
                    color: MyColor.greyDark),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 2),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Text(
                    'Mobile: ',
                    style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 0.27,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                        color: MyColor.greyDark),
                  ),
                  Text(
                    phone,
                    style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 0.27,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                        color: MyColor.addressHeaderColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}



class AddressWidget2 extends StatelessWidget {
  String name,phone,email,address;
  Function deletAddress;
  AddressWidget2(this.name,this.phone,this.email,this.address,this.deletAddress);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.3)),
      child: Container(

        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 16,
                        color: MyColor.greyDark,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.24),
                  ),
                ),
               /* Padding(
                    padding: EdgeInsets.only(top: 10, right: 15),
                    child:index==position?Image.asset('images/check_ic.png',width: 20,height: 20,):Container()


                  *//*Container(
                    width: 73,
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyColor.boxAddressColor,
                    ),
                    child: Center(
                      child: Text(
                        'Office',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),*//*
                )*/
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Text(
                address,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 0.27,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w500,
                    color: MyColor.greyDark),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15, top: 2),
              child: Text(
                email,
                style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 0.27,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w500,
                    color: MyColor.greyDark),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 2),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Text(
                    'Mobile: ',
                    style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 0.27,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                        color: MyColor.greyDark),
                  ),
                  Text(
                    phone,
                    style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 0.27,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                        color: MyColor.addressHeaderColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Container(
              padding: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5, left: 15),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.3)),
                      child: Container(
                        width: 133.3,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0, left: 0),
                          child: Center(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Gilroy',
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.3),
                          gradient: LinearGradient(
                            colors: <Color>[
                              MyColor.gradientStart,
                              MyColor.gradientEnd
                            ],
                          ),
                          color: Colors.white,
                        ),
                        height: 32,
                      ),
                    ),
                  ),


                 InkWell(
                   onTap: (){

                   },
                   child:   Container(
                     width: 133.3,
                     child: UnicornOutlineButton(
                       strokeWidth: 1,
                       radius: 8.3,
                       gradient: LinearGradient(
                         colors: [
                           MyColor.gradientEnd,
                           MyColor.gradientStart
                         ],
                         begin: Alignment.topCenter,
                         end: Alignment.bottomCenter,
                       ),
                       child: GradientText(
                         'Remove',
                         gradient: LinearGradient(colors: [
                           MyColor.gradientStart,
                           MyColor.gradientEnd
                         ]),
                       ),
                       onPressed: () {deletAddress();},
                     ),
                     height: 32,
                   ),
                 )

                ],
              ),
            ),



            SizedBox(height: 13,)











          ],
        ),
      ),
    );
  }
}

