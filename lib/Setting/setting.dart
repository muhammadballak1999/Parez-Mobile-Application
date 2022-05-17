import 'package:flutter/material.dart';
import 'package:flutter_auth/Setting/body.dart';
import 'package:flutter_auth/generated/l10n.dart';

class Setting extends StatefulWidget {
  const Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(S.of(context).language),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.purple,
                Colors.deepPurple,
              ])),
        ),
      ),
      body: Body(),
    );
  }
}
