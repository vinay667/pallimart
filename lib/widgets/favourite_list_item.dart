import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/utils/constants.dart';
import 'package:pallimart/utils/login_Dialog.dart';

class FavouriteListItem extends StatefulWidget {
  String image,productName,productPrice,unit;
  String quantity;
  FavouriteListItem(this.image,this.productName,this.productPrice,this.unit,this.quantity);
  @override
  _FavouriteListItemState createState() => _FavouriteListItemState(image,productName,productPrice,unit,quantity);

}

class _FavouriteListItemState extends State<FavouriteListItem> {
  String image,productName,productPrice,unit;
  String quantity;

  _FavouriteListItemState(this.image,this.productName,this.productPrice,this.unit,this.quantity);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .45,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                  ),
                  boxShadow: [
                    new BoxShadow(
                        color: MyColor.themeColor.withOpacity(0.5),
                        blurRadius: 7.0,

                    ),
                  ]
              ),

              margin: EdgeInsets.only(bottom: 42, left: 4, right: 4),
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child:  FadeInImage.assetNetwork(
                      height: 180,
                      placeholder: 'images/app_logo.png',
                      image: Constants.imageBaseUrl+image,
                    ),),
                 /* Image.asset(
                    'images/cross.png',
                    height: 36,
                    width: 36,
                  ),*/
                ],
              ),
            ),
            Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 8,
                margin: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                child: Container(
                  width: MediaQuery.of(context).size.width * .45,
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
                        productName,
                        style: TextStyle(
                            color: MyColor.homeItemTitleColor,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    quantity.toString()+' '+unit,
                                    style: TextStyle(
                                        color: MyColor.homeItemSubTitleColor,
                                        fontSize: 9.3,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Gilroy'),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Rs. '+productPrice,
                                        style: TextStyle(
                                            color: MyColor.homeItemTitleColor,
                                            fontSize: 10.7,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Gilroy'),
                                      ),

                                    ],
                                  )
                                ],
                              )),
                          GestureDetector(
                            onTap: (){
                              if(UserModel.accessToken=='notLogin')
                                {
                                  LoginDialog.showLogInDialog(context, 'Login to add Product !!');
                                }
                              else{



                              }
                            },
                            child: Image.asset('images/home_icon_delete.png'),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
