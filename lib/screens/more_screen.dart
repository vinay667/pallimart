import 'package:flutter/material.dart';
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
                AccountItem(
                  callback: this,
                  image: 'images/icon_help.png',
                  title: 'Help',
                  subTitle: 'Do you need help?',
                ),
                Divider(),
                AccountItem(
                  callback: this,
                  image: 'images/icon_faq.png',
                  title: 'FAQ',
                  subTitle: 'Get your all answer here',
                ),
                Divider(),
                AccountItem(
                  callback: this,
                  image: 'images/icon_about.png',
                  title: 'About Us',
                  subTitle: 'know more about us',
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
