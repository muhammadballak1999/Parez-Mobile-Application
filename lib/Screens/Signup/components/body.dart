import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/Screens/components/rounded_button.dart';
import 'package:flutter_auth/Screens/components/rounded_input_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/generated/l10n.dart';
import 'package:flutter_auth/home_page.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_svg/svg.dart';

import '../../Login/otp_verify.dart';

class Body extends StatefulWidget {
  String phone;
  Body({Key key, this.phone}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Map<String, dynamic> response;
  bool loading = false;

  postData() async {
    setState(() {
      loading = true;
    });
    try {
      await http
          .post(Uri.parse("https://parez-backend.herokuapp.com/otp-sign-up"),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "phone": widget.phone,
              }))
          .then((res) => response = jsonDecode(res.body));
      // ignore: unnecessary_statements
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Center(
            child: Container(
                child: CircularProgressIndicator(
            color: Colors.purple,
          )))
        : Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    S.of(context).womenRights,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: kPrimaryColor),
                  ),

                  SizedBox(height: size.height * 0.05),
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.35,
                  ),
                  RoundedInputField(
                    icon: Icons.phone,
                    hintText: "750 XXXX XXX",
                    onChanged: (value) {
                      widget.phone = value;
                    },
                  ),
                  RoundedButton(
                    text: S.of(context).signUpText,
                    press: () async {
                      await postData();
                      if (response["success"]) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpVerify(
                                  phone: widget.phone, method: 'signup')),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                    title: Text(S.of(context).warning),
                                    content: Text(
                                        S.of(context).knownNO),
                                    actions: [
                                      new FlatButton(
                                          child:  Text(S.of(context).okButton),
                                          onPressed: () => {Navigator.pop(_)}),
                                    ]),
                            barrierDismissible: false);
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
