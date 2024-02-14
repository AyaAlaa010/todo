import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/layout_view.dart';
class SplashScreen extends StatefulWidget {
  static String routeName="/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds:4),(){
      Navigator.pushReplacementNamed(context, LayoutView.routeName);

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;

    return Scaffold(
      body: Image.asset("assets/images/splash.png",height: mediaQuery.height,width: mediaQuery.width,),
    );
  }
}
