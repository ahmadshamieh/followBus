import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:followbus/adminPage/addDriverAdmin.dart';
import 'package:followbus/adminPage/addStudantAdmain.dart';
import 'package:followbus/adminPage/adminScreen.dart';
import 'package:followbus/homeScreenDriver.dart';
import 'package:followbus/startScreens/login.dart';
import 'package:followbus/startScreens/splashScreen.dart';

void main() async {
  HttpClient createHttpClient(SecurityContext context) {
    return createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}
