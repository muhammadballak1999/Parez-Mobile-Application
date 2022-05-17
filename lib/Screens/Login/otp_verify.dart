// ignore_for_file: must_call_super, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/generated/l10n.dart';
import 'package:flutter_auth/home_page.dart';
import 'package:flutter_auth/models/api_services.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_auth/Screens/components/rounded_button.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/async.dart';

class OtpVerify extends StatefulWidget {
  final String phone;
  final String method;

  const OtpVerify({Key key, this.phone, this.method}) : super(key: key);
  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  APIService apiService = APIService();
  String _otpCode = "";
  Map<String, dynamic> response;
  final int _otpCodeLength = 6;
  bool isAPICallProcess = false;
  bool showTry = false;
  FocusNode myFocusNode;
  bool loading = false;

  int start = 15;
  String current = "15";
  int remain = 15;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      if (mounted)
        setState(() {
          remain = start - duration.elapsed.inSeconds;
        });
      if (mounted)
        setState(() {
          current = remain < 10 ? "0$remain" : "$remain";
        });
    });

    sub.onDone(() {
      if (mounted)
        setState(() {
          showTry = true;
        });
      sub.cancel();
    });
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
    SmsAutoFill().listenForCode.call();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: loading
            ? Center(
                child: Container(
                    child: CircularProgressIndicator(
                color: Colors.purple,
              )))
            : ProgressHUD(
                key: UniqueKey(),
                inAsyncCall: isAPICallProcess,
                child: Center(
                  child: SingleChildScrollView(
                    child: verifyOtpUi(),
                  ),
                )),
      ),
    );
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    myFocusNode.dispose();
    super.dispose();
  }

  verifyOtpUi() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/illustration-3.png",
              height: 180,
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                S.of(context).otpVerify,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "${S.of(context).enterOtp}\n +964-${widget.phone}",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              25,
              0,
              25,
              0,
            ),
            child: PinFieldAutoFill(
              keyboardType: TextInputType.number,
              decoration: UnderlineDecoration(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                colorBuilder: FixedColorBuilder(
                  Colors.black.withOpacity(.3),
                ),
              ),
              onCodeChanged: (code) {
                if (code.length == _otpCodeLength) {
                  _otpCode = code;
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RoundedButton(
              text: S.of(context).verify,
              press: () async {
                if (mounted)
                  setState(() {
                    loading = true;
                  });

                response = await APIService.otpVerify(
                    widget.phone, _otpCode, widget.method);
                if (response["success"]) {
                  print(response["data"]["accessToken"]);
                  final SharedPreferences prefs = await _prefs;
                  prefs.setString("accessToken",
                      'Bearer ' + response["data"]["accessToken"]);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => MyHomePage()),
                      (route) => false);
                  if (mounted)
                    setState(() {
                      showTry = true;
                    });
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                              title: Text(S.of(context).warning),
                              content: Text(S.of(context).otpText),
                              actions: [
                                new FlatButton(
                                    child: Text(S.of(context).okButton),
                                    // ignore: sdk_version_set_literal
                                    onPressed: () => {Navigator.pop(_)}),
                              ]),
                      barrierDismissible: false);
                  if (mounted)
                    setState(() {
                      loading = false;
                    });
                }
              }),
          // ignore: sdk_version_set_literal
          showTry
              ? SizedBox(
                  height: 50,
                  child: TextButton(
                      // ignore: sdk_version_set_literal
                      onPressed: () async => {
                            // ignore: sdk_version_ui_as_code
                            if (mounted)
                              setState(() {
                                remain = 15;
                                current = "15";
                                showTry = false;
                                startTimer();
                              }),
                            // ignore: sdk_version_ui_as_code
                            if (widget.method == 'login')
                              {await APIService.otpLogin(widget.phone)}
                            else
                              {
                                await APIService.post('otp-sign-up/resend',
                                    {"phone": widget.phone})
                              },
                          },
                      child: Text(
                        S.of(context).tryAgain,
                        style: TextStyle(color: kPrimaryColor),
                      )),
                )
              : Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      S.of(context).tryAgain +" "+S.of(context).In+ " 00:$current",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
        ]);
  }
}
