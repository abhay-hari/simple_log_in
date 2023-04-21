import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/Login Page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_options.dart';

const SAVE_KEY_NAME = 'userLoggedIn';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {});
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenLogin(),
    );
  }

  // void gotoLogin(BuildContext context) {
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => ScreenLogin()));
  // }

  // // Future<void> checkUserLoggedIn(BuildContext context) async {
  //   final sharedPref = await SharedPreferences.getInstance();
  //   // sharedPref.setBool(SAVE_KEY_NAME, true);
  //   final userLoggedin = sharedPref.getBool(SAVE_KEY_NAME);
  //   if (userLoggedin == null || userLoggedin == false) {
  //     gotoLogin(context);
  //   }else{

  //   }
  // }
}