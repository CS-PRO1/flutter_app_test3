import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  dynamic widget;
  SplashScreen(this.widget);
  @override
  SplashScreenState createState() => SplashScreenState(widget);
}

class SplashScreenState extends State<SplashScreen> {
  dynamic next;
  SplashScreenState(this.next);
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => next)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: double.infinity,
          color: Color.fromARGB(255, 255, 72, 72),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/basket.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          )),
    );
  }
}



