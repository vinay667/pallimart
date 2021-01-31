

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/widgets/custom_container_widget.dart';
import 'package:pallimart/widgets/input_field_border.dart';
import 'package:toast/toast.dart';

class AddAddressScreen extends StatefulWidget {
  AddAddressState createState() => AddAddressState();
}
class AddAddressState extends State<AddAddressScreen>{
  var _fromData;
  String dropdownSelectedItem = 'Address Type';
  List<String> listItems = ['Address Type', 'HOME', 'WORK'];
  FocusNode houseFocusNode = new FocusNode();
  FocusNode roadFocusNode = new FocusNode();
  FocusNode stateFocusNode = new FocusNode();
  FocusNode pinFocusNode = new FocusNode();
  FocusNode lNameNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();
  FocusNode cityFocusNode = new FocusNode();
  FocusNode addressNode = new FocusNode();
  var textControllerFlatNo = new TextEditingController();
  var textControllerColony = new TextEditingController();
  var textControllerState = new TextEditingController();
  var textControllerPinCode = new TextEditingController();
  var textControllerLastName = new TextEditingController();
  var textControllerEmail = new TextEditingController();
  var textControllerAddress = new TextEditingController();
  var textControllerCity = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 50),
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child:
                  Image.asset('images/back_icon.png', width: 30, height: 17,color: MyColor.themeColor,),
                ),
              ),
              SizedBox(width: 20),
              Text('Add Address',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'George',
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),


          SizedBox(height: 10),


          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: CustomContainer(
              labelText: 'First Name',
              focusNode: houseFocusNode,
              controller: textControllerFlatNo,
              onTap: _requestFocusHouseNo,
              hintText: 'Enter First Name',
              textBgColor: Colors.white,
            ),
          ),

          SizedBox(height: 5),

          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: CustomContainer(
              labelText: 'Last Name',
              focusNode: lNameNode,
              controller: textControllerLastName,
              onTap: _requestFocusLastName,
              hintText: 'Enter Last Name',
              textBgColor: Colors.white,
            ),
          ),

          SizedBox(height: 5),

          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: CustomContainer(
              labelText: 'Phone Number',
              focusNode: roadFocusNode,
              controller: textControllerColony,
              onTap: _requestFocusRoad,
              hintText: 'Enter Phone Number',
              textBgColor: Colors.white,
            ),
          ),


          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: CustomContainer(
              labelText: 'Email',
              focusNode: emailFocusNode,
              controller: textControllerEmail,
              onTap: _requestFocusEmail,
              hintText: 'Enter Email',
              textBgColor: Colors.white,
            ),
          ),


          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: CustomContainer(
              labelText: 'Address',
              focusNode: addressNode,
              controller: textControllerAddress,
              onTap: _requestFocusAddress,
              hintText: 'Enter Address',
              textBgColor: Colors.white,
            ),
          ),


          SizedBox(height: 5),

          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: CustomContainer(
              labelText: 'City',
              focusNode: cityFocusNode,
              controller: textControllerCity,
              onTap: _requestFocusCity,
              hintText: 'Enter City',
              textBgColor: Colors.white,
            ),
          ),



          SizedBox(height: 5),


          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[


                Flexible(
                  child:   InputFieldBorder(
                    labelText: 'State',
                    focusNode: stateFocusNode,
                    onTap: _requestFocusState,
                    hintText: 'Enter State',
                    controller: textControllerState,
                    textBgColor: Colors.white,
                  ),
                ),
                SizedBox(width: 15),
                Flexible(
                  child: InputFieldBorder(
                    labelText: 'Pincode',
                    focusNode: pinFocusNode,
                    onTap: _requestFocusPin,
                    hintText: 'Enter Pin Code',
                    controller: textControllerPinCode,
                    isNumerickeyboard: true,
                    textBgColor: Colors.white,
                  ),
                )


              ],
            ),
          ),





          SizedBox(height: 35),


          InkWell(
            onTap: () {
              //addAddress();
              if(textControllerFlatNo.text=='')
                {
                  Toast.show('First name cannot be empty !!', context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.black);
                }
              if(textControllerLastName.text=='')
              {
                Toast.show('Last name cannot be empty !!', context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.black);
              }
              else if(textControllerColony.text=='')
                {
                  Toast.show('Phone number cannot be empty !!', context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.black);
                }

              else if(textControllerEmail.text=='')
              {
                Toast.show('Email cannot be empty !!', context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.black);
              } else if(textControllerAddress.text=='')
              {
                Toast.show('Address cannot be empty !!', context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.black);
              } else if(textControllerCity.text=='')
              {
                Toast.show('City cannot be empty !!', context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.black);
              }














              else if(textControllerState.text=='')
              {
                Toast.show('State cannot be empty !!', context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor: Colors.black);
              }
              else if(textControllerPinCode.text.length!=6)
                {
                  Toast.show('Pin code length should be equal to 6  !!', context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.black);
                }

              else
                addAddress();


            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child:Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 25),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/roundedRectangle.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Text(
                    "Add New Address",
                    style: TextStyle(
                        color: MyColor.whiteColor,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600),
                  ) // button text
              ),
            )
          ),



        ],
      ),



    );
  }




  void _requestFocusHouseNo() {
    setState(() {
      FocusScope.of(context).requestFocus(houseFocusNode);
    });
  }

  void _requestFocusLastName() {
    setState(() {
      FocusScope.of(context).requestFocus(lNameNode);
    });
  }
  void _requestFocusEmail() {
    setState(() {
      FocusScope.of(context).requestFocus(emailFocusNode);
    });
  }
  void _requestFocusAddress() {
    setState(() {
      FocusScope.of(context).requestFocus(addressNode);
    });
  }
  void _requestFocusCity() {
    setState(() {
      FocusScope.of(context).requestFocus(cityFocusNode);
    });
  }


  void _requestFocusRoad() {
    setState(() {
      FocusScope.of(context).requestFocus(roadFocusNode);
    });
  }

  void _requestFocusState() {
    setState(() {
      FocusScope.of(context).requestFocus(stateFocusNode);
    });
  }
  void _requestFocusPin() {
    setState(() {
      FocusScope.of(context).requestFocus(pinFocusNode);
    });
  }
  addAddress() async {
    _fromData["firstName"]=textControllerFlatNo.text;
    _fromData["pinCode"]=textControllerPinCode.text;
    _fromData["phoneNumber"]=textControllerColony.text;
    _fromData["lastName"]=textControllerLastName.text;
    _fromData["state"]=textControllerState.text;
    _fromData["emailAddress"]=textControllerEmail.text;
    _fromData["address"]=textControllerAddress.text;
    _fromData["city"]=textControllerCity.text;
    FocusScope.of(context).unfocus();
    print(_fromData.toString());
    APIDialog.showAlertDialog(context, 'Adding Address...');
    ApiBaseHelper helper = new ApiBaseHelper();
    var response = await helper.postAPIFormData(
        'product/api/shipping/address',
        context,_fromData);
    Navigator.pop(context);
    print(response);
    if(response['status'].toString()=='success')

      {
        Toast.show('Address Added successfully !!', context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.black);
        Navigator.pop(context,'Address Added');
      }
    else{
      Toast.show(response['message'], context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.black);
    }

  }

 /* setAddress() async {

    textControllerFlatNo.text=AddressModel.flatNo;
    textControllerColony.text=AddressModel.road;
    textControllerState.text=AddressModel.state;
    textControllerPinCode.text=AddressModel.pinCode.toString();

  }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fromData = {
      'firstName':'',
      'lastName':'',
      'phoneNumber':'',
      'emailAddress': '',
      'address':'',
      'pinCode':'',
      'city':'',
      'state':'',
    };

  }




}