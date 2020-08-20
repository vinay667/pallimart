
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
class AddressWidget extends StatelessWidget {
  String name,phone,email,address;
  AddressWidget(this.name,this.phone,this.email,this.address);
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
                  child:Image.asset('images/check_ic.png',width: 20,height: 20,)
                  
                  
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





