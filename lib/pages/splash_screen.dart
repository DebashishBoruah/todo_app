import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoapp/pages/myhomepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:2),(){
      setState(() {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyHomePage()));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height:200,
          width: 200,
          child: Image(image: AssetImage("assets/logo/todoapp_logo.png"))),
      ),
    );
  }
}