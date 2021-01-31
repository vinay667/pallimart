import 'package:flutter/material.dart';
import 'package:pallimart/screens/about_us_screen.dart';
import 'package:pallimart/screens/faqs_screen.dart';
import 'package:pallimart/screens/help_screen.dart';
import 'package:pallimart/widgets/account_item.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Card(
          elevation: 8,
          margin: EdgeInsets.all(12),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
               InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpScreen()));
                 },
                 child:  AccountItem(
                   image: 'images/icon_help.png',
                   title: 'Help',
                   subTitle: 'Do you need help?',
                 ),
               ),
                Divider(),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FaqScreen()));
                  },
                  child: AccountItem(
                    image: 'images/icon_faq.png',
                    title: 'FAQ',
                    subTitle: 'Get your all answer here',
                  ),
                ),
                Divider(),
               InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsScreen()));
                 },
                 child:  AccountItem(
                   image: 'images/icon_about.png',
                   title: 'About Us',
                   subTitle: 'know more about us',
                 ),
               )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
