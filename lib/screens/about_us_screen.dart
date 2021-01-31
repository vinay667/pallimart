


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/widgets/toolbar_widget.dart';

class AboutUsScreen extends StatefulWidget
{
  AboutUsState createState()=>AboutUsState();
}
class AboutUsState extends State<AboutUsScreen>
{
  String descriptionText='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ToolbarWidget('About Us'),
            Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),

                    child:  Padding(
                      padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                        style: TextStyle(fontSize: 14.0, color: Color(0xaa585858),fontFamily: 'Gilroy',fontWeight: FontWeight.w500,height: 1.2),
                      ),
                    )
                )


            )



          ],

        ),
      ),



    );


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

}