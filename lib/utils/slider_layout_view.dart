import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pallimart/screens/login_screen.dart';
import 'package:pallimart/utils/slide_dots.dart';
import 'package:pallimart/utils/slide_item.dart';
class SliderLayoutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}
class _SliderLayoutViewState extends State<SliderLayoutView> {
  static int _currentPage = 0;
  List<String> imagesList=['images/1_u.jpg','images/2_u.jpg','images/3_u.jpg','images/4_u.jpg,'];
  final PageController _pageController = PageController(initialPage: _currentPage,keepPage: true, viewportFraction: 1);

  @override
  void initState() {
    super.initState();
    print('trigger done ');
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage= _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    print('huu');
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Container(
    child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: 4,
              itemBuilder: (ctx, i) => SlideItem(i),
            ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                GestureDetector(
                  onTap: (){

                    print(_currentPage.toString()+'rtrtrt');
                    if(_currentPage<3)
                    {
                      setState(() {
                        _currentPage++;
                        //_pageController.jumpToPage(_currentPage);
                        _pageController.animateToPage(_currentPage, curve: Curves.decelerate, duration: Duration(milliseconds: 200));
                      });
                      // _currentPage=_currentPage+1;
                    }
                    else if(_currentPage==3)
                    {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    //  _currentPage=0;
                    }
                    //_onPageChanged(_currentPage);
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                      child: Text(
                        'NEXT',
                        style: TextStyle(decoration:TextDecoration.none,fontSize: 15,color: Colors.white,fontFamily: 'GilroySemibold',fontWeight: FontWeight.bold,letterSpacing: 3),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){


                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    //_currentPage=0;
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>RefineSearchScreen()));


                  },
                  child:  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                      child: Text(
                        'SKIP',
                        style: TextStyle(decoration:TextDecoration.none,fontSize: 15,color: Colors.white,fontFamily: 'GilroySemibold',fontWeight: FontWeight.bold,letterSpacing: 3),
                      ),
                    ),
                  ),


                ),
                Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < 4; i++)
                        if (i == _currentPage)
                          SlideDots(true)
                        else
                          SlideDots(false)
                    ],
                  ),
                ),
              ],
            )
          ],
        )),
  );
}