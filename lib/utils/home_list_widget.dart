import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/utils/product_list_item.dart';

class HomeListView extends StatefulWidget {
  @override
  _HomeListViewState createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  List<String> categoryImage = ['images/shampoo.png','images/surf.jpg','images/oil.jpg','images/sugar.jpeg','images/moil.jpeg','images/aata.jpeg','images/maggi.jpg','images/dettol.jpg'];
  List<String> categoryName = ['Sunsilk Shampoo','Surf Excel','HairOil','Sugar','Mustard Oil','Aata','Maggi','Dettol',];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryImage.length,
            padding: EdgeInsets.only(left: 12, right: 12),
            itemBuilder: (context, index) {
              return Container(
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
              child: Image.asset(
              categoryImage[index],
              height: 180,
              fit: BoxFit.fill,
              )),
              Image.asset(
              'images/icon_fav.png',
              height: 36,
              width: 36,
              color: Colors.white,
              ),
              ],
              ),
              ),
              Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
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
              categoryName[index],
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
              "1 KG",
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
              ));
            }));
  }
}
