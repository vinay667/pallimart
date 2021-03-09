import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pallimart/screens/bottom_tab_screen.dart';
import 'package:pallimart/screens/cart_items_screeen.dart';
import 'package:pallimart/screens/favourite_sceen.dart';
import 'package:pallimart/screens/home.dart';
import 'package:pallimart/screens/login_screen.dart';
import 'package:pallimart/screens/splash_screen.dart';
import 'package:pallimart/screens/sub_category_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors/colors.dart';
import 'models/user_model.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=await prefs.getString('access_token') ?? 'notLogin';
  String pageValue=await prefs.getString('page_value');
  if(token!='notLogin')
    {
      String count=await prefs.getString('count');
      UserModel.setAccessToken(token);
      UserModel.setCartCount(count);
    }

  print(token);
  //print(await prefs.getString('name'));
  runApp(MyApp(token,pageValue));
}
class MyApp extends StatelessWidget {
  String token,pageValue;
  MyApp(this.token,this.pageValue);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColor.themeColor
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(token,pageValue),
      routes: {
        '/home': (BuildContext context) => HomeScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/search': (BuildContext context) => FavouriteScreen('NA',true),
        '/subc': (BuildContext context) => SubCategoryScreen(''),
        '/cart': (BuildContext context) => CartItemsScreen(),
        '/bottom': (BuildContext context) => BottomTabScreen(),
      },
    );
  }
}



