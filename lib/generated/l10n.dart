// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hi welcome`
  String get welcomeText {
    return Intl.message(
      'Hi welcome',
      name: 'welcomeText',
      desc: 'the programmer greeting',
      args: [],
    );
  }

  /// `Women Rights`
  String get womenRights {
    return Intl.message(
      'Women Rights',
      name: 'womenRights',
      desc: 'chini bashi',
      args: [],
    );
  }

  /// `Login`
  String get loginText {
    return Intl.message(
      'Login',
      name: 'loginText',
      desc: 'Login',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpText {
    return Intl.message(
      'Sign Up',
      name: 'signUpText',
      desc: 'SignUp',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: 'Help',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: 'News',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passText {
    return Intl.message(
      'Password',
      name: 'passText',
      desc: 'Password',
      args: [],
    );
  }

  /// `Full Name`
  String get emailText {
    return Intl.message(
      'Full Name',
      name: 'emailText',
      desc: 'Your Email',
      args: [],
    );
  }

  /// `Don’t have an Account ? `
  String get dontHaveAcc {
    return Intl.message(
      'Don’t have an Account ? ',
      name: 'dontHaveAcc',
      desc: 'Don’t have an Account ? ',
      args: [],
    );
  }

  /// `Already have an Account ?`
  String get haveAcc {
    return Intl.message(
      'Already have an Account ?',
      name: 'haveAcc',
      desc: 'Already have an Account ? ',
      args: [],
    );
  }

  /// `My Account`
  String get myAcc {
    return Intl.message(
      'My Account',
      name: 'myAcc',
      desc: 'My Account',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: 'Notifications',
      args: [],
    );
  }

  /// `Help Center`
  String get helpCenter {
    return Intl.message(
      'Help Center',
      name: 'helpCenter',
      desc: 'Help Center',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: 'Log out',
      args: [],
    );
  }

  /// `0750 XXX XXXX`
  String get phoneNO {
    return Intl.message(
      '0750 XXX XXXX',
      name: 'phoneNO',
      desc: 'phone number',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: 'About Us',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: 'Language',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termCondition {
    return Intl.message(
      'Terms & Conditions',
      name: 'termCondition',
      desc: 'Terms & Conditions',
      args: [],
    );
  }

  /// `Announcements & Rules`
  String get rules {
    return Intl.message(
      'Announcements & Rules',
      name: 'rules',
      desc: 'rules',
      args: [],
    );
  }

  /// `PUSH\nHOLD`
  String get helpButton {
    return Intl.message(
      'PUSH\nHOLD',
      name: 'helpButton',
      desc: 'helpButton',
      args: [],
    );
  }

  /// `HOLD\nREJECT`
  String get rejectButton {
    return Intl.message(
      'HOLD\nREJECT',
      name: 'rejectButton',
      desc: 'rejectButton',
      args: [],
    );
  }

  /// `No blogs found :(`
  String get noBlogs {
    return Intl.message(
      'No blogs found :(',
      name: 'noBlogs',
      desc: 'No blogs found',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: 'warning',
      args: [],
    );
  }

  /// `The phone number you entered is not registered!`
  String get unknownNO {
    return Intl.message(
      'The phone number you entered is not registered!',
      name: 'unknownNO',
      desc: 'warning',
      args: [],
    );
  }

  /// `Ok`
  String get okButton {
    return Intl.message(
      'Ok',
      name: 'okButton',
      desc: 'OK',
      args: [],
    );
  }

  /// `The otp number you entered is wrong! Please try again.`
  String get otpText {
    return Intl.message(
      'The otp number you entered is wrong! Please try again.',
      name: 'otpText',
      desc: 'otp',
      args: [],
    );
  }

  /// `The phone number you entered already registered!`
  String get knownNO {
    return Intl.message(
      'The phone number you entered already registered!',
      name: 'knownNO',
      desc: 'known no',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: 'tryAgain',
      args: [],
    );
  }

  /// `Enter Otp code sent to your mobile`
  String get enterOtp {
    return Intl.message(
      'Enter Otp code sent to your mobile',
      name: 'enterOtp',
      desc: 'enterOtp',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: 'verify',
      args: [],
    );
  }

  /// `Otp Verification`
  String get otpVerify {
    return Intl.message(
      'Otp Verification',
      name: 'otpVerify',
      desc: 'otpVerify',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: 'Name',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: 'Phone NUmber',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: 'City',
      args: [],
    );
  }

  /// `Martial Status`
  String get martialSt {
    return Intl.message(
      'Martial Status',
      name: 'martialSt',
      desc: 'Martial Status',
      args: [],
    );
  }

  /// `Edit Information`
  String get editInfo {
    return Intl.message(
      'Edit Information',
      name: 'editInfo',
      desc: 'edit info',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: 'close',
      args: [],
    );
  }

  /// `Approve`
  String get approve {
    return Intl.message(
      'Approve',
      name: 'approve',
      desc: 'Approve',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: 'Back',
      args: [],
    );
  }

  /// `From Gallery`
  String get gallery {
    return Intl.message(
      'From Gallery',
      name: 'gallery',
      desc: 'gallery',
      args: [],
    );
  }

  /// `From Camera`
  String get camera {
    return Intl.message(
      'From Camera',
      name: 'camera',
      desc: 'camera',
      args: [],
    );
  }

  /// `Choose`
  String get choose {
    return Intl.message(
      'Choose',
      name: 'choose',
      desc: 'choose',
      args: [],
    );
  }

  /// `in`
  String get In {
    return Intl.message(
      'in',
      name: 'In',
      desc: 'in',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fa'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}