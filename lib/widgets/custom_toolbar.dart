import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../colors/colors.dart';

class CustomToolbar extends StatelessWidget {
  CustomToolbar(this.header, this.contextF);

  final String header;
  final BuildContext contextF;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      elevation: 6,
      child: Container(
          height: 55,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {




                  },
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image.asset('images/hamber2.png',
                        width: 22.3, height: 14.3),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Center(
                    child: Container(
                      child: Text(
                        header,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18,
                            color: MyColor.textBlueColor,
                            decoration: TextDecoration.none,
                            fontFamily: 'GilroySemibold'),
                      ),
                    )),
                flex: 5,
              ),
              Expanded(
                child: Container(
                    height: 40.3,
                    width: 25.3,
                    margin: EdgeInsets.only(right: 10),
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage(
                              "images/girl_dp.jpg",
                            )))),
                flex: 1,
              )
            ],
          )),



    );
  }
}
