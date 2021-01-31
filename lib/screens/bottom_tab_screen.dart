import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/callbacks/button_click_callback.dart';
import 'package:pallimart/colors/colors.dart';
import 'package:pallimart/models/user_model.dart';
import 'package:pallimart/screens/profile_screen.dart';
import 'package:pallimart/utils/constants2.dart';
import 'package:pallimart/utils/login_Dialog.dart';
import 'package:pallimart/widgets/appbar_widget.dart';
import 'package:pallimart/widgets/icon_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account_screen.dart';
import 'category_screen.dart';
import 'favourite_sceen.dart';
import 'home.dart';
import 'login_screen.dart';
import 'more_screen.dart';
import 'my_orders_screen.dart';
import 'navigation_category_screen.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class BottomTabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomTabState();
  }
}

class BottomTabState extends State<BottomTabScreen>
    implements ButtonClickListener {
  String selectedLang='English';
  GlobalKey<ScaffoldState> _key = GlobalKey();
  int selectLANG=0;
  String userName = '', userEmail = '';
  final List<Widget> _children = [
    HomeScreen(),
    FavouriteScreen('NA', false),
    AccountScreen(),
    MoreScreen(),
    CategoryScreen(),
  ];
  bool clickedCentreFAB =
      false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex =
      0; //to handle which item is currently selected in the bottom app bar

  @override
  void onButtonClickListener(int id) {
    if (id == Constants2.SEARCH_CLICK_ID)
      Navigator.pushNamed(context, '/search');
    else if (id == Constants2.CART_ID) {
      if (UserModel.accessToken == 'notLogin') {
        showLogInDialog(context);
      } else {
        Navigator.pushNamed(context, '/cart');
      }
    } else
      setState(() {
        clickedCentreFAB = false;
        selectedIndex = id;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: selectedIndex == 2
          ? null
          : selectedIndex == 3
              ? AppbarWidget(
                  context: context,
                  clickListener: this,
                  counter: 3,
                  isBack: false,
                  type: "more",
                  title: "More on App",
                )
              : AppbarWidget(
                  context: context,
                  clickListener: this,
                  counter: 3,
                  isBack: false,
                  type: "home",
                  onTap: () {
                    _key.currentState.openDrawer();
                  },
                  //_children[selectedIndex]
                  title: clickedCentreFAB ? "Categories" : null,
                ),
      drawer: Container(
        width: 250.3,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  /* Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ProfileScreen(token)));*/
                },
                child: Container(
                  color: MyColor.themeColor,
                  height: 200.3,
                  child: DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15, top: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, top: 20, bottom: 5),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.blueAccent),
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      'images/logo.png'))),
                                          /*CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey.withOpacity(0.7),
              child: Image.asset(
                'images/app_logo.png',
              ),
            ),*/
                                        )),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 5, bottom: 3),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: new BoxDecoration(
                                            color: MyColor.themeColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            padding:
                                EdgeInsets.only(left: 15, top: 20, right: 4),
                            child: Text(
                              userName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'GilroySemibold',
                                  color: Colors.white),
                            )),
                        Container(
                            width: double.infinity,
                            padding:
                                EdgeInsets.only(left: 15, top: 7, right: 5),
                            child: Text(
                              userEmail ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'GilroySemibold',
                                  color: Colors.white),
                            )),
                      ],
                    )),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  selectedLang=='English'?
                  'Change Language':'भाषा बदलें',
                  style: TextStyle(
                      fontSize: 16,
                      color: MyColor.textBlueColor,
                      decoration: TextDecoration.none,
                      fontFamily: 'GilroySemibold'),
                ),
                onTap: () {

                  if(selectedLang=='English')
                    {
                      selectLANG=0;
                    }
                  else
                    selectLANG=1;

/*
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>AccountScreen()));*/

                  return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        int selectedRadio = selectLANG;
                        return AlertDialog(
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List<Widget>.generate(2, (int index) {
                                  return Row(
                                    children: <Widget>[



                                      Radio<int>(
                                        value: index,
                                        activeColor: MyColor.themeColor,
                                        groupValue: selectedRadio,
                                        onChanged: (int value) {

                                          setState(() {
                                            selectedRadio = value;
                                            if(index==0)
                                              {


                                                _updateViews('English');

                                              }
                                            else{


                                              _updateViews('Hindi');

                                            }


                                          });

                                        },
                                      ),

                                      Text(index==0?'English':'हिन्दी',style: TextStyle(fontFamily: 'GilroySemiBold',color: Colors.black87),),



                                    ],
                                  );
                                }),
                              );
                            },
                          ),
                        );
                      });
                },
              ),
              ListTile(
                title: Text(
                  selectedLang=='English'?
                  'Account':'खाता',
                  style: TextStyle(
                      fontSize: 16,
                      color: MyColor.textBlueColor,
                      decoration: TextDecoration.none,
                      fontFamily: 'GilroySemibold'),
                ),
                onTap: () {
                  if (UserModel.accessToken == 'notLogin') {
                    LoginDialog.showLogInDialog(
                        context, 'Please Login to view Account !!');
                  } else {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AccountScreen()));
                  }
                },
              ),
              ListTile(
                title: Text(
                  selectedLang=='English'?
                  'My Profile':'प्रोफाइल',
                  style: TextStyle(
                      fontSize: 16,
                      color: MyColor.textBlueColor,
                      decoration: TextDecoration.none,
                      fontFamily: 'GilroySemibold'),
                ),
                onTap: () {
                  if (UserModel.accessToken == 'notLogin') {
                    LoginDialog.showLogInDialog(
                        context, 'Please Login to view Account !!');
                  } else {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ProfileScreen()));
                  }
                },
              ),
              ListTile(
                title: Text(
                  selectedLang=='English'?
                  'Orders':'मेरे चीज़े',
                  style: TextStyle(
                      fontSize: 16,
                      color: MyColor.textBlueColor,
                      decoration: TextDecoration.none,
                      fontFamily: 'GilroySemibold'),
                ),
                onTap: () {
                  if (UserModel.accessToken == 'notLogin') {
                    LoginDialog.showLogInDialog(
                        context, 'Please Login to view Account !!');
                  } else {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => MyOrdersScreen()));
                  }
                },
              ),
              ListTile(
                title: Text(
                  selectedLang=='English'?
                  'Shop by Category':'वर्गों के अनुसार',
                  style: TextStyle(
                      fontSize: 16,
                      color: MyColor.textBlueColor,
                      decoration: TextDecoration.none,
                      fontFamily: 'GilroySemibold'),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => NCategoryScreen()));
                },
              ),
              ListTile(
                title: Text(
                  selectedLang=='English'?
                  'Buy Again':'फिर से खरीदें',
                  style: TextStyle(
                      fontSize: 16,
                      color: MyColor.textBlueColor,
                      decoration: TextDecoration.none,
                      fontFamily: 'GilroySemibold'),
                ),
                onTap: () {},
              ),
              UserModel.accessToken == 'notLogin'
                  ? ListTile(
                      title: Text(
                        selectedLang=='English'?
                        'Log In':'लॉग इन करें',
                        style: TextStyle(
                            fontSize: 16,
                            color: MyColor.textBlueColor,
                            decoration: TextDecoration.none,
                            fontFamily: 'GilroySemibold'),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    )
                  : ListTile(
                      title: Text(
                        selectedLang=='English'?
                        'Log Out':'लॉग आउट',
                        style: TextStyle(
                            fontSize: 16,
                            color: MyColor.textBlueColor,
                            decoration: TextDecoration.none,
                            fontFamily: 'GilroySemibold'),
                      ),
                      onTap: () {
                        showLogOutDialog(context);
                      },
                    )
            ],
          ),
        ),
      ),
      body: Builder(builder: (ctx) => _children[selectedIndex]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //specify the location of the FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          if (clickedCentreFAB) return;
          setState(() {
            selectedIndex = 4;
            clickedCentreFAB = true; //to update the animated container
          });
        },
        tooltip: "Centre FAB",
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0),
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: const Alignment(0.7, -0.5),
              end: const Alignment(0.6, 0.5),
              colors: [
                MyColor.themeColor,
                Color(0xFF42D8C0),
              ],
            ),
          ),
          child: Image.asset('images/floating_icon.png'),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButtonWidget(this, "images/icon_home.png", 0, selectedIndex),
              IconButtonWidget(this, "images/icon_fav.png", 1, selectedIndex),
              SizedBox(
                width: 50.0,
              ),
              IconButtonWidget(this, "images/icon_user.png", 2, selectedIndex),
              IconButtonWidget(
                  this, "images/icon_others.png", 3, selectedIndex),
            ],
          ),
        ),
        //to add a space between the FAB and BottomAppBar
        shape: CircularNotchedRectangle(),
        //color of the BottomAppBar
        color: Colors.white,
      ),
    );
  }

  showLogOutDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            ModalRoute.withName("/bottom"));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Are you sure you want to Log out ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  setUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? '';
      userEmail = prefs.getString('email') ?? '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserData();
  }

  showLogInDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes,Login"),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => LoginScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log in"),
      content: Text("To view cart items you need to login !"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _updateViews(String language)
  {

    setState(() {
      selectedLang=language;
    });
  }


}
