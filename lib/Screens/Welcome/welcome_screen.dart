import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/components/body.dart';
import 'package:flutter_auth/constants.dart';
import 'package:provider/provider.dart';

import '../../LanguageChangeProvider.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Body(),
    );
  }
}
