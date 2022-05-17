import 'package:flutter/material.dart';
import 'package:flutter_auth/Setting/profile_pic.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/generated/l10n.dart';
import 'package:flutter_auth/models/api_services.dart';

final myController1 = TextEditingController();
final myController2 = TextEditingController();
final myController3 = TextEditingController();
FocusNode myFocusNode1 = new FocusNode();

class MyAccount extends StatefulWidget {
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Map<String, dynamic> response1;
  Map<String, dynamic> response2;
  Map<String, dynamic> response3;
  Map<String, dynamic> user;
  String imageUrl;
  String selectval = "married";
  List statuses = [];
  // ignore: non_constant_identifier_names
  List marital_status = [];

  bool loading = true;

  getUser() async {
    if (loading == false) {
      setState(() {
        loading = true;
      });
    }
    response1 = await APIService.get('me');
    if (response1["success"]) {
      setState(() {
        user = response1["data"];
        imageUrl = response1["data"]["attachment"] != null
            ? response1["data"]["attachment"]["url"]
            : "";
        loading = false;
        selectval = user["marital_status"] != null
            ? user["marital_status"]["status"]
            : "Decline to identify";
      });
    }
    setState(() {
      loading = false;
    });
  }

  getMaritalStatus() async {
    response2 = await APIService.get('marital-status');
    for (var i = 0; i < response2["data"].length; i++) {
      statuses.add(
          // DropdownMenuItem<String>(
          // child:
          response2["data"][i]["status"]
          // value: response2["data"][i]["status"])
          );
    }
    print(statuses);
    setState(() {
      marital_status = response2["data"];
    });
  }

  updateMe() async {
    var body = {
      "name": myController1.text,
      "city": myController2.text,
      "marital_status": marital_status[statuses.indexOf(selectval)]["id"]
    };
    response3 = await APIService.put('me', body);
    getUser();
  }

  @override
  void dispose() {
    super.dispose();
    // myController1.dispose();
    // myController2.dispose();
    // myController3.dispose();
  }

  @override
  void initState() {
    super.initState();

    getUser();
    getMaritalStatus();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            tooltip: S.of(context).back,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
        title: Text(S.of(context).myAcc),
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
        actions: [
          IconButton(
            // ignore: sdk_version_set_literal
            onPressed: () => {
              myController1.text = user["name"] != null ? user["name"] : null,
              myController2.text = user["city"] != null ? user["city"] : null,
              myController3.text = user["marital_status"] != null
                  ? user["marital_status"]["status"]
                  : null,
              _showMyDialog(context)
            },
            icon: Icon(Icons.edit),
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: loading
            ? Container(
                height: size.height,
                width: size.width,
                child: Center(
                    child: Container(
                        child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ))),
              )
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfilePic(imageUrl: imageUrl),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      S.of(context).name,
                      style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      user["name"] != null && user["name"] != ""
                          ? user["name"]
                          : 'Not Set',
                      style: TextStyle(
                          color: kPrimaryColor,
                          letterSpacing: 2.0,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      S.of(context).phoneNumber,
                      style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      user["phone"] != null ? user["phone"] : 'Not Set',
                      style: TextStyle(
                          color: kPrimaryColor,
                          letterSpacing: 2.0,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      S.of(context).city,
                      style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      user["city"] != null ? user["city"] : 'Not Set',
                      style: TextStyle(
                          color: kPrimaryColor,
                          letterSpacing: 2.0,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      S.of(context).martialSt,
                      style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      user["marital_status"] != null
                          ? user["marital_status"]["status"]
                          : 'Not Set',
                      style: TextStyle(
                          color: kPrimaryColor,
                          letterSpacing: 2.0,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<State> _showMyDialog(context) async {
    return showDialog<State>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).editInfo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(height: 10),
                TextFormField(
                  controller: myController1,
                  focusNode: myFocusNode1,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: kPrimaryColor),
                    fillColor: Colors.deepPurple,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 2.0)),
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: kPrimaryColor,
                        width: 1.0,
                      ),
                    ),
                    labelText: S.of(context).name,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: myController2,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: kPrimaryColor),
                    fillColor: kPrimaryColor,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: kPrimaryColor, width: 2.0)),
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Colors.purple,
                        width: 1.0,
                      ),
                    ),
                    labelText: S.of(context).city,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                            hint: Text(S.of(context).martialSt),
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            value: selectval,
                            onChanged: (newValue) {
                              setState(() {
                                selectval = newValue;
                              });
                            },
                            items: statuses
                                .map((item) => DropdownMenuItem<String>(
                                      child: Text(item),
                                      value: item,
                                    ))
                                .toList())))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: Text(S.of(context).close,
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
              child: Text(S.of(context).approve,
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                updateMe();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
