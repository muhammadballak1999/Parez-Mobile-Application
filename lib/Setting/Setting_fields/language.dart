import 'package:flutter/material.dart';
import 'package:flutter_auth/LanguageChangeProvider.dart';
import 'package:flutter_auth/Setting/setting.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/generated/l10n.dart';
import 'package:provider/provider.dart';

class Language extends StatefulWidget {
  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            tooltip:S.of(context).back ,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
          child: Column(
            children: [
              FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  height: 40,
                  minWidth: 200,
                  textColor: Colors.white,
                  color: kPrimaryColor,
                  onPressed: () {
                    context.read<LanguageChangeProvider>().changeLocale("ar");
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),

                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    "العربية",
                    style: TextStyle(fontSize: 30.0),
                  )),
              SizedBox(
                height: 30.0,
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  height: 40,
                  minWidth: 200,
                  textColor: Colors.white,
                  color: kPrimaryColor,
                  onPressed: () {
                    context.read<LanguageChangeProvider>().changeLocale("fa");
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    "کوردی",
                    style: TextStyle(fontSize: 30.0),
                  )),
              SizedBox(
                height: 30.0,
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  height: 50,
                  minWidth: 200,
                  textColor: Colors.white,
                  color: kPrimaryColor,
                  onPressed: () {
                    context.read<LanguageChangeProvider>().changeLocale("en");
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    "English",
                    style: TextStyle(fontSize: 30.0),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
