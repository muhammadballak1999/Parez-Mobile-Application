import 'package:flutter/material.dart';
import 'package:flutter_auth/LanguageChangeProvider.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/generated/l10n.dart';
import 'package:flutter_auth/models/notificationservice.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auth/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
  return;
}

Future<void> firebaseMessagingOnMessageOpenedAppHandler(
    RemoteMessage message) async {
  NotificationService().showNotification(
      1, message.notification.title, message.notification.body);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage
      .listen(firebaseMessagingOnMessageOpenedAppHandler);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLoggedIn = false;

  checkAuth() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.get("accessToken") != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
            locale: Provider.of<LanguageChangeProvider>(context, listen: true)
                .currentLocale,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: Colors.white,
            ),
            home: isLoggedIn ? MyHomePage() : WelcomeScreen());
      }),
    );
  }
}
