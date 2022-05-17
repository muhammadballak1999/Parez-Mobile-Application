import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Setting/Setting_fields/about_us.dart';
import 'package:flutter_auth/Setting/Setting_fields/announcements_and_rules.dart';
import 'package:flutter_auth/Setting/Setting_fields/language.dart';
import 'package:flutter_auth/Setting/Setting_fields/legal.dart';
import 'package:flutter_auth/Setting/Setting_fields/my_account.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  alertDialog(context) {
    return AlertDialog(
      title: Text("Warning"),
      content: Text("Are you sure to Log Out?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
          child: Text("Ok"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileMenu(
            icon: "assets/icons/User Icon.svg",
            text: S.of(context).myAcc,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAccount()),
              );
            },
          ),
          ProfileMenu(
            icon: "assets/icons/language.svg",
            text: S.of(context).language,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Language()),
              );
            },
          ),
          ProfileMenu(
            icon: "assets/icons/Question mark.svg",
            text: S.of(context).termCondition,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => termsConditions()),
              );
            },
          ),
          ProfileMenu(
            icon: "assets/icons/Bell.svg",
            text: S.of(context).rules,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnnouncementsAndRules()),
              );
            },
          ),
          ProfileMenu(
            icon: "assets/icons/info.svg",
            text: S.of(context).aboutUs,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()),
              );
            },
          ),
          ProfileMenu(
            icon: "assets/icons/Log out.svg",
            text: S.of(context).logOut,
            press: () async {
              final SharedPreferences prefs = await _prefs;
              prefs.remove('accessToken');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);
  final text, icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: FlatButton(
        height: 30,
        minWidth: 80,
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.grey[100],
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 25,
              color: Colors.purple,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 17),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
