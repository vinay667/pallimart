import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/utils/api_dialog.dart';
import 'package:pallimart/utils/no_internet_check.dart';
import 'package:pallimart/widgets/address_widget.dart';
import 'package:pallimart/screens/payment_screen.dart';
import 'package:toast/toast.dart';
class AllAddressScreen extends StatefulWidget {
  AllAddressState createState() => AllAddressState();
}

class AllAddressState extends State<AllAddressScreen> {

  String name='',phone='',email='',address='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: MyColor.textBlueColor, //change your color here
        ),
        title: Text(
          "Select Address",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'All Addresses',
              style: TextStyle(
                  fontFamily: 'Geomanist',
                  fontSize: 16,
                  color: MyColor.cartTextColor),
            ),
          ),




          Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: AddressWidget(name,phone,email,address),
                  );
                }),
          ),
         GestureDetector(
           onTap: (){

      Navigator.push(context, CupertinoPageRoute(builder: (context)=>PaymentScreen()));



           },
           child: Card(
             elevation: 30,
             margin: EdgeInsets.zero,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(20),
                   topRight: Radius.circular(20),
                 )),
             child: Container(
                 height: 50,
                 alignment: Alignment.center,
                 padding: EdgeInsets.all(12),
                 margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                       image: AssetImage("images/roundedRectangle.png"),
                       fit: BoxFit.fill),
                 ),
                 child: Text(
                   "Continue",
                   style: TextStyle(
                       color: MyColor.whiteColor,
                       fontFamily: 'Gilroy',
                       fontWeight: FontWeight.w600),
                 ) // button text
             ),
           )

         )
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAPIcall();
  }
  fetchUserAddress() async {
    ApiBaseHelper helper=new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Fetching Addresses');
    var response=await helper.getWithToken('product/api/shipping/address', context);
    Navigator.pop(context);
    print(response);
    setState(() {
      name=response['data']['shippingAddress']['firstName']+' '+response['data']['shippingAddress']['lastName'];
      phone=response['data']['shippingAddress']['phoneNumber'].toString();
      email=response['data']['shippingAddress']['emailAddress'];
      address=response['data']['shippingAddress']['address'];
    });
  }

  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      fetchUserAddress();
    } else {
      Toast.show('No Internet connection !!!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: MyColor.noInternetColor);

    }
  }
}
