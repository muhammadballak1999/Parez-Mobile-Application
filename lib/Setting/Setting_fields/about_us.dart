import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/generated/l10n.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUs extends StatefulWidget {
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future getData() async {
    final SharedPreferences prefs = await _prefs;
    var url = Uri.parse('https://parez-backend.herokuapp.com/about');
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: prefs.get('accessToken'),
      },
    );
    return jsonDecode(response.body)["data"]["content"].replaceAll("&lt;", "<");
  }

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
        title: Text(S.of(context).aboutUs),
        centerTitle: true,
        flexibleSpace: Container(

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.purple,
                Colors.deepPurple,
              ],
            ),
          ),
        ),

      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Html(data: snapshot.data),
            );
          } else {
            return Center(
                child: Container(
                    child: CircularProgressIndicator(
              color: kPrimaryColor,
            )));
          }
        },
      ),
    );
  }
}
