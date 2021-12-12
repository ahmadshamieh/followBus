import 'dart:async';
import 'package:flutter/material.dart';
import 'package:followbus/main.dart';
import 'package:followbus/startScreens/introScreen.dart';

// ignore: use_key_in_widget_constructors
class Splash extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        // ignore: prefer_const_constructors
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          height: screenwidth * .5,
          width: screenwidth * .5,
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: ExactAssetImage('assets/school-bus-gif.gif'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
