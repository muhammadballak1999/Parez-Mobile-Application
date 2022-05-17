import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/HelpButton/help_button.dart';
import 'package:flutter_auth/Setting/setting.dart';
import 'package:flutter_auth/bottombar/blogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Login/login_screen.dart';
import 'generated/l10n.dart';
import 'models/api_services.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _controller = PageController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  getMe() async {
    Map<String, dynamic> response = await APIService.get("me");
    print(response);
    if (response["data"]["isSuspended"]) {
      final SharedPreferences prefs = await _prefs;
      prefs.remove('accessToken');
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    }
  }

  var _bottomNavIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
    getMe();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final iconList = <IconData>[
    Icons.web,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _bottomNavIndex = index;
          }); // This is required to update the nav bar if Android back button is pressed
        },
        children: const <Widget>[
          Blogs(),
          Setting(),
        ],
      ), //destination screen
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.red,
        /*shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),*/
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelpButton()),
          );
        },
        child: Text(
          S.of(context).help,
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.red[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _showBottomBar(context),
    );
  }

  Widget _showBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.deepPurple])),
      child: AnimatedBottomNavigationBar(
        icons: iconList,
        iconSize: 35.0,
        inactiveColor: Colors.white,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.sharpEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        activeColor: Colors.yellow,
        backgroundColor: Colors.transparent,

        onTap: (index) {
          setState(() => _bottomNavIndex = index);
          _controller.jumpToPage(index);
        },

        //other params
      ),
    );
  }
}
