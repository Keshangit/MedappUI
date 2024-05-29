import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_assist/constants.dart';
import 'package:med_assist/services/auth_service.dart';
import 'package:med_assist/services/firebaseauth.dart';
import 'package:med_assist/ui/landing/splash/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  String? token = await FirebaseMessaging.instance.getToken();
  log(token ?? "TOKEN NULL");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
      ],
      child: const MedAssistApp(),
    ),
  );
}

class MedAssistApp extends StatelessWidget {
  const MedAssistApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: kGrey,
        statusBarColor: kLightGrey,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MED_ASSIST',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: kWhite,
      ),
      home: const SplashScreen(),
    );
  }
}
