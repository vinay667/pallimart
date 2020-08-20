import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
class ProductListItem extends StatefulWidget {
  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: ()=> Navigator.pushNamed(context, "/product_detail"),child:Container(
        width: MediaQuery.of(context).size.width * .45,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Card(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 42, left: 4, right: 4),
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg',
                        height: 180,
                        fit: BoxFit.fill,
                      )),
                  Image.asset(
                    'images/icon_fav.png',
                    height: 36,
                    width: 36,
                    color: MyColor.whiteColor,
                  ),
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
                        "Xiaomi Mi A3",
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
                                "64GB Storage",
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
                                    "\$1500",
                                    style: TextStyle(
                                        color: MyColor.homeItemTitleColor,
                                        fontSize: 10.7,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Gilroy'),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "\$2500",
                                    style: TextStyle(
                                        color: MyColor.homeItemSubTitleColor,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 7.8,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Gilroy'),
                                  ),
                                ],
                              )
                            ],
                          )),
                          Image.asset('images/home_icon_delete.png')
                        ],
                      )
                    ],
                  ),
                )),
          ],
        )));
  }
}
