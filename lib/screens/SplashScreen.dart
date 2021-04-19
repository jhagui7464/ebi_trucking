import 'package:flutter/material.dart';
import 'dart:async';
import 'ShowScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, navigatetoLoginScreen);
  }

  navigatetoLoginScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ShowScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFE5251E), Color(0xFF262626)],
        ),
      ),

      child: Center(
        child: Image.asset(
          'assets/images/ebi_02.png',
          height: 140,
          width: 110,
        ),
      ),
    ));
  }
}
