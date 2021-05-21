/*import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:soryor/utils/constans.dart';

class Home extends StatefulWidget {
  final String ad;

  Home({this.ad});
  // Home({@required this.ad});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  var _bottomNavIndex = 0; //default index of first screen

  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  final iconList = <IconData>[
    Icons.trending_up,
    Icons.access_alarm,
    Icons.hail,
    Icons.person,
  ];
  /*final widgets = <Widget>[
    HomePage(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
    Addquestion()
  ];*/
  List<String> kelime = [
    "trendler".tr(),
    "topluluk".tr(),
    "takip".tr(),
    "profil".tr(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );

    debugPrint("1!!!!!!initstate");
  }

  static PageController pageController =
      PageController(); //initstate mi alsan vre dispose

  static void onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget build(BuildContext context) {
    debugPrint("home buildde");
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: awidgets,
        physics: NeverScrollableScrollPhysics(),
      ), //awidgets[_bottomNavIndex],
      //NavigationScreen(
      //  awidgets[_bottomNavIndex],
      //),
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor: Colors.teal, //HexColor('#FFA400'),
          child: Icon(
            Icons.plus_one,
            color: HexColor('#373A36'),
          ),
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                context: context,
                builder: (context) {
                  return buildbottom(context);
                });
            //bottom nav barda baska sayfaya gitmek ivinn
            //  _onItemTapped(4);
            //    _animationController.reset();
            //      _animationController.forward();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive
                ? Colors.black
                : Colors.white; // HexColor('#FFA400') : Colors.white;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: color,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    kelime[index],
                    maxLines: 1,
                    style: TextStyle(color: color),
                  ),
                )
              ],
            );
          },
          backgroundColor: Colors.blueAccent, //HexColor('#373A36'),
          activeIndex: _bottomNavIndex,
          splashColor: HexColor('#FFA400'),
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => onItemTapped(
              index) //(index) => setState(() => _bottomNavIndex = index),
          ),
    );
  }

  Container buildbottom(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 300,
      // color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          Container(
            height: 225,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.grey[300], spreadRadius: 5)
                ]),
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration.collapsed(hintText: 'Soru'),
                  ),
                ),
                MaterialButton(
                  color: Colors.grey[800],
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Sor',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class NavigationScreen extends StatefulWidget {
  final Widget widg;

  NavigationScreen(this.widg) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;
  Animation<double> animation;
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.widg != widget.widg) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("navigation buildde");
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: CircularRevealAnimation(
            animation: animation,
            centerOffset: Offset(80, 80),
            maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
            child: widget.widg),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soryor/provider/themeprovider.dart';
import 'package:soryor/ui/anasayfa.dart';
import 'package:soryor/ui/profileui.dart';
import 'package:soryor/ui/toplulukui.dart';
import 'package:soryor/ui/trendscreen.dart';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final String ad;

  Home({this.ad});
  // Home({@required this.ad});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  List<Widget> _widgets = <Widget>[
    HomePage(),
    Anasayfa(),
    Toplulukui(),
    Profileui(),
  ];

  PageController pageController =
      PageController(); //initstate mi alsan vre dispose

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    debugPrint("1!!!!!!initstate");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("!!!!!!!rebuiltttt");
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: _widgets,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor:, //Colors.blue,
        //  selectedItemColor: Colors.white,
        //  unselectedItemColor: Colors.grey.shade300,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: "trendler".tr()),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "akis".tr()),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.userFriends), label: "topluluk".tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "profil".tr()),

          //   BottomNavigationBarItem(
          //         icon: Icon(Icons.settings), title: Text("YEDEK")),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
