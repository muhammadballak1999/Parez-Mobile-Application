import 'dart:convert';
import 'dart:io';

import 'package:flutter_auth/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class APIService {
  static var client = http.Client();
  static Future<Map<String, dynamic>> otpLogin(String phone) async {
    var url = Uri.parse(Config.otpLoginAPI + phone);
    var response = await client.get(url);
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> otpVerify(
      String phone, String otpCode, String method) async {
    if (method == 'login') {
      var url = Uri.parse(Config.otpVerifyAPI + phone + '/' + otpCode);
      var response = await client.get(url);
      print(json.decode(response.body));

      return json.decode(response.body);
    } else {
      var url = Uri.parse(Config.apiURL + 'otp-sign-up-verify');
      var response =
          await client.post(url, body: {"phone": phone, "otp": otpCode});
      print(json.decode(response.body));
      return json.decode(response.body);
    }
  }

  static Future<Map<String, dynamic>> get(String resource) async {
    final SharedPreferences prefs = await _prefs;

    var url = Uri.parse(Config.apiURL + resource);
    var response = await client.get(url,
        headers: {HttpHeaders.authorizationHeader: prefs.get('accessToken')});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> post(String resource, body) async {
    final SharedPreferences prefs = await _prefs;

    var url = Uri.parse(Config.apiURL + resource);
    var response = await client.post(url,
        body: body,
        headers: {HttpHeaders.authorizationHeader: prefs.get('accessToken')});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> put(String resource, body) async {
    final SharedPreferences prefs = await _prefs;

    var url = Uri.parse(Config.apiURL + resource);
    var response = await client.put(url,
        body: body,
        headers: {HttpHeaders.authorizationHeader: prefs.get('accessToken')});
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> delete(String resource) async {
    final SharedPreferences prefs = await _prefs;

    var url = Uri.parse(Config.apiURL + resource);
    var response = await client.delete(url,
        headers: {HttpHeaders.authorizationHeader: prefs.get('accessToken')});
    return json.decode(response.body);
  }
}
