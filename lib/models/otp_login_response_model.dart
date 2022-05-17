import 'dart:convert';
import 'dart:ffi';


OtpLoginResponseModel otpLoginResponseModel(str) =>
    OtpLoginResponseModel.fromJson(json.decode(str));

class OtpLoginResponseModel {
  Bool success;
  String message;
  String data;

  OtpLoginResponseModel({
    this.success,
    this.message,
    this.data,
  });
  OtpLoginResponseModel.fromJson(Map<String, dynamic> json) {
    success:
    json["success"];
    message = json['message'];
    data = json['data'];
  }
}
