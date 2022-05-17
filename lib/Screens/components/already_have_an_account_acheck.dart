import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/generated/l10n.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? S.of(context).dontHaveAcc : S.of(context).haveAcc ,
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? S.of(context).signUpText : S.of(context).loginText,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
