// ignore_for_file: sdk_version_set_literal

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/models/api_services.dart';
import 'package:flutter_auth/Screens/Login/otp_verify.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/Screens/components/rounded_button.dart';
import 'package:flutter_auth/Screens/components/rounded_input_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/generated/l10n.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String phone;
  Map<String, dynamic> response;
  bool loading = false;
  APIService apiService = APIService();
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
                    S.of(context).loginText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: kPrimaryColor),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    icon: Icons.phone,
                    hintText: "750xxxxxxx",
                    onChanged: (value) {
                      phone = value;
                    },
                  ),
                  RoundedButton(
                    text: S.of(context).loginText,
                    press: () async {
                      setState(() {
                        loading = true;
                      });
                      response = await APIService.otpLogin(phone);
                      if (response["success"]) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OtpVerify(phone: phone, method: 'login')),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                    title: Text(S.of(context).warning),
                                    content: Text(S.of(context).unknownNO),
                                    actions: [
                                      new FlatButton(
                                          child: Text(S.of(context).okButton),
                                          onPressed: () => {Navigator.pop(_)}),
                                    ]),
                            barrierDismissible: false);
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
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
