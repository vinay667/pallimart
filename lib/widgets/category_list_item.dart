import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/category_model.dart';

class CategoryListItem extends StatefulWidget {
  final CategoryModel item;
  final  double bottomPadding,textSize;
  final double iconHeight,elevation;


  const CategoryListItem({Key key, this.item,this.bottomPadding=4, this.iconHeight=46.0, this.textSize=12.7,this.elevation=4.0}) : super(key: key);

  @override
  _CategoryListItemState createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.pushNamed(context, "/search"),
        child: Container(
          width: MediaQuery.of(context).size.width/4.3,
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: widget.bottomPadding, left: 4, right: 4, top: widget.elevation),
            elevation: widget.elevation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  widget.item.icon,
                  height: widget.iconHeight,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.item.name.toUpperCase(),
                  style: TextStyle(
                      color: MyColor.homeTextColor,
                      fontSize: widget.textSize,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ));
  }
}
