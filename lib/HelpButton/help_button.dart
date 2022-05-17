import 'package:flutter/material.dart';
import 'package:flutter_auth/HelpButton/button.dart';
import 'package:flutter_auth/generated/l10n.dart';

class HelpButton extends StatefulWidget {
  @override
  _HelpButtonState createState() => _HelpButtonState();
}

class _HelpButtonState extends State<HelpButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(S.of(context).help),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.purple,
                Colors.deepPurple,
              ])),
        ),
      ),
      body: Container(
        color: Color(0xFF14293A),
        child: Center(
          child: RippleButton(
            size: 0.4,
          ),
        ),
      ),
    );
  }
}
