import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/widgets/toolbar_widget.dart';

class HelpScreen extends StatefulWidget {
  HelpScreenState createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  String descriptionText = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry. ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Column(
      children: <Widget>[
      ToolbarWidget('Help'),
      Expanded(
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
              ]),
              child: Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(
                  descriptionText,
                  style: TextStyle(fontSize: 15.0, color: Color(0xaa585858),fontFamily: 'Gilroy',fontWeight: FontWeight.w600,height: 1.2),
                ),
              )))
      ],
    ),
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


}
