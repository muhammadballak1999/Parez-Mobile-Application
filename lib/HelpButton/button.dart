import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auth/HelpButton/button_animation.dart';
import 'package:flutter_auth/generated/l10n.dart';
import 'package:flutter_auth/home_page.dart';
import 'package:flutter_auth/models/api_services.dart';
import 'package:location/location.dart';

class RippleButton extends StatefulWidget {
  const RippleButton({Key key, @required this.size}) : super(key: key);

  final double size;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RippleButton> {
  List<Widget> _anims = [];
  String userId;
  String rejectStatusId;
  bool isInDanger = false;
  bool loading = true;
  int _animationsRunning = 0;
  var _pressed = false;

  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  requestLocationService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  getHelp() async {
    var body = {
      "latitude": "36.14",
      "longitude": "44.02",
      "condition": "Not set"
    };

    Map<String, dynamic> response2 =
        await APIService.post("violence-cases", body);
    print(response2);
  }

  reject() async {
    Map<String, dynamic> response3 =
        await APIService.put("violence-cases/user/reject", {});
  }

  getUser() async {
    Map<String, dynamic> response1 = await APIService.get("me");
    setState(() {
      loading = false;
      isInDanger = response1["data"]["isInDanger"];
      userId = response1["data"]["_id"];
    });
  }

  @override
  void initState() {
    super.initState();
    requestLocationService();
    getUser();
  }

  void animationEnded() {
    _animationsRunning--;
    if (_animationsRunning == 0) {
      setState(() {
        _anims = [];
      });
    }
  }

  Timer timer1;
  Timer timer2;
  void _runRipple() {
    timer1 = Timer.periodic(const Duration(milliseconds: 300), (Timer t) {
      if (_pressed) {
        _startAnimation();
      } else {
        timer1.cancel();
      }
    });
  }

  void _startAnimation() {
    setState(() {
      _anims.add(RippleAnimation(
        animationEnded,
        key: UniqueKey(),
        size: widget.size,
      ));

      _animationsRunning++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Center(
          child: loading
              ? Container(
                  child: CircularProgressIndicator(
                  color: Colors.purple,
                ))
              : GestureDetector(
                  onLongPress: () {
                    setState(() {
                      _pressed = true;
                    });
                    timer2 = Timer.periodic(const Duration(milliseconds: 2000),
                        (Timer t) async {
                      if (isInDanger == false) {
                        await getHelp();
                      } else {
                        await reject();
                      }
                      timer1.cancel();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => MyHomePage()),
                          (route) => false);
                      timer2.cancel();
                    });
                    _runRipple();
                  },
                  onLongPressEnd: (_) {
                    timer2.cancel();
                    setState(() {
                      _anims = [];
                      _pressed = false;
                    });
                  },
                  child: Container(
                    child: Center(
                        child: Text(
                      isInDanger ? S.of(context).rejectButton : S.of(context).helpButton,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )),
                    width: (_size.width * widget.size),
                    height: (_size.width * widget.size),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isInDanger ? Colors.red : Colors.green),
                  ),
                ),
        ),
        // ignore: sdk_version_ui_as_code
        ..._anims,

      ],
    );
  }
}
