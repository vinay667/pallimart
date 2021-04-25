import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/dfr.dart';
import 'package:pallimart/network/api_helper.dart';
import 'package:pallimart/screens/add_address_screen.dart';
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
  List<dynamic> addressList=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: MyColor.textBlueColor, //change your color here
        ),
        title: Text(
          "All Address",
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
              addressList.length!=0?"All Addresses":'',
              style: TextStyle(
                  fontFamily: 'Geomanist',
                  fontSize: 16,
                  color: MyColor.cartTextColor),
            ),
          ),




          addressList.length==0?

          Expanded(
            child: Center(
              child:  Text(
                "No Address found !!",
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Gilroy',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ) // button text,
            ),
          ):

          Expanded(
            child: ListView.builder(
                itemCount: addressList.length,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: AddressWidget2(addressList[position]['firstName']+' '+addressList[position]['lastName'],addressList[position]['phoneNumber'].toString(),addressList[position]['emailAddress'],addressList[position]['address'],(){

                      removeAddress(addressList[position]['id']);

                    },() async {
                      // Edit Address logic

                      AddressModel.setAddressID(addressList[position]['id'].toString());
                      print(addressList[position]['id'].toString());

                      var result=await Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddAddressScreen('update')));

                      if(result!=null)
                      {
                        checkInternetAPIcall();
                      }



                    }),
                  );
                }),
          ),
         GestureDetector(
           onTap: ()async{

     // Navigator.push(context, CupertinoPageRoute(builder: (context)=>PaymentScreen()));
        var result=await Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddAddressScreen('edit')));

        if(result!=null)
          {
            checkInternetAPIcall();
          }



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
                   "Add New Address",
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
      addressList=response['data']['customerAddresses'];
    });
  }

  removeAddress(int addID) async {
    var _fromData = {
      'id': addID.toString(),
    };

    print(_fromData);
    ApiBaseHelper helper = new ApiBaseHelper();
    APIDialog.showAlertDialog(context, 'Removing address...');
    var response = await helper.postAPIFormData(
        'product/api/delete/shipping/address', context, _fromData);
    Navigator.pop(context);
    if (response['status'] == 'success') {
      Toast.show('Address removed Successfully !!', context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.black);
      Navigator.pop(context);
    } else {
      Toast.show(response['message'], context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: MyColor.noInternetColor);
    }
    print(response);
  }



  void checkInternetAPIcall() async {
    if (await InternetCheck.check() == true) {
      fetchUserAddress();
    } else {
      Toast.show('No Internet connection !!!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor: MyColor.noInternetColor);

    }
  }
}
