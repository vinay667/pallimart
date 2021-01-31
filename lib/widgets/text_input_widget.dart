import 'package:flutter/material.dart';
import 'package:pallimart/callbacks/text_field_callback.dart';
import 'package:pallimart/colors/colors.dart';

class MyTextInputField extends StatelessWidget {
  TextFieldCallback callback;
  String label;
  String inputType;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  var controller;
  MyTextInputField(this.callback, this.label, this.inputType, this.currentFocus,
      this.nextFocus,this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label.toUpperCase(),
              style: TextStyle(
                  fontSize: 13.3,
                  color: MyColor.homeTitleColor,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/roundedRectangleTextField.png"),
                        fit: BoxFit.fill)),
                child: TextFormField(
                    expands: false,
                    controller: controller,
                    focusNode: currentFocus,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    style: TextStyle(
                        color: MyColor.blackColor,
                        fontSize: 10.7,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600),
                    textInputAction: nextFocus == null
                        ? TextInputAction.go
                        : TextInputAction.next,
                    obscureText: inputType.compareTo("password") == 0,
                    maxLines: 1,
                    keyboardType: inputType.compareTo("email") == 0
                        ? TextInputType.emailAddress
                        : inputType.compareTo("phone") == 0
                            ? TextInputType.phone
                            : TextInputType.text,
                    onSaved: (String value) {
                      callback.onInputFieldSave(label, value);
                    },
                    onFieldSubmitted: (term) {
                      currentFocus.unfocus();
                      if (nextFocus != null)
                        FocusScope.of(context).requestFocus(nextFocus);
                    }))
          ],
        ));
  }
}
