import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_chat/screens/choose_product_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChooseProduct()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'images/img.png',
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
        ),
      ),
    );
  }
}
