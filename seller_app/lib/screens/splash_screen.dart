import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seller_app/auth/auth_screen.dart';
import 'package:seller_app/global/global.dart';

import '../mainScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  void startTimer()
  {
    Timer(const Duration(seconds: 3), () async{
      if(firebaseAuth.currentUser != null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      }
      else
        {
          Navigator.popAndPushNamed(context,'/auth');
        }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/splash.jpg"),
              const SizedBox(height: 10),
               const Padding(
                padding: EdgeInsets.all(18.0),
                 child: Text(
                   "Sell Food Online",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: Colors.black54,
                     fontSize: 40,
                     fontFamily: "Signatra",
                     letterSpacing: 3,
                   ),
                 ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
