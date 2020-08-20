import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';

class AccountItem extends StatelessWidget {
  final image, title, subTitle;
  final callback;

  const AccountItem(
      {Key key, this.image, this.title, this.subTitle, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => callback.onTypeClickListener(title),
        child: Row(
          children: <Widget>[
            Image.asset(image),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: MyColor.blackColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy',
                        fontSize: 10.7),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                        color: MyColor.accountSubTitleColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy',
                        fontSize: 9.3),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.navigate_next,
            )
          ],
        ));
  }
}
