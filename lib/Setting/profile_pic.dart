import 'dart:io';
import 'package:flutter_auth/models/api_services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/generated/l10n.dart';
import 'package:flutter_auth/models/config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class ProfilePic extends StatefulWidget {
  final String imageUrl;
  ProfilePic({Key key, this.imageUrl}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File image;
  String url = "";
  Response<dynamic> response;
  bool loading = false;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      var formData = new FormData.fromMap({
        'attachment': await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last,
            contentType: MediaType("image", 'jpg')),
        "type": "image/jpg"
      });
      final SharedPreferences prefs = await _prefs;
      var dio = Dio();
      setState(() {
        loading = true;
      });
      response = await dio.put(Config.apiURL + "users/profile/image/update",
          data: formData,
          options: Options(headers: {
            "accept": "*/*",
            "Authorization": "${prefs.get('accessToken')}",
            "Content-type": "mulitpart/form-data"
          }));
      setState(() {
        url = response.data["data"]["url"];
        loading = false;
      });
      // final imageTemporary = File(image.path);

      // setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to pick image:$e");
    }
  }

  deleteImage() async {
    setState(() {
      loading = true;
    });
    await APIService.delete("users/profile/image/delete");
    setState(() {
      url = "";
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      url = widget.imageUrl;
    });
    print(url);
  }

  void cameraOrGallery() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () => pickImage(ImageSource.gallery),
                  icon: Icon(
                    Icons.image_outlined,
                    color: kPrimaryColor,
                  ),
                  label: Text(
                    S.of(context).gallery,
                    style: TextStyle(fontSize: 20, color: kPrimaryColor),
                  ),
                ),
                Divider(),
                TextButton.icon(
                  onPressed: () => pickImage(ImageSource.camera),
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: kPrimaryColor,
                  ),
                  label: Text(
                    S.of(context).camera,
                    style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          scrollable: true,
          title: Text(S.of(context).choose),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 135,
      width: 115,
      child: Stack(
        overflow: Overflow.visible,
        fit: StackFit.passthrough,
        children: [
          !loading
              ? url != ""
                  ? Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                      image: NetworkImage(this.url),
                    )))
                  : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                      image: AssetImage("assets/images/photo.jpg"),
                    )))
              : Container(
                  child: CircularProgressIndicator(
                  color: Colors.purple,
                )),
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white)),
                onPressed: () => cameraOrGallery(),
                color: Colors.grey[300],
                child: SvgPicture.asset(
                  "assets/icons/Camera Icon.svg",
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          url != ""
              ? Positioned(
                  left: -12,
                  top: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () => {_showMyDialog()},
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure?'),
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
                deleteImage();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
