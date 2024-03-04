import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/layout_view.dart';
import 'package:todo/features/login/pages/login_view.dart';

import '../../settings_providers.dart';
class SplashScreen extends StatefulWidget {

  static String routeName="/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds:2),(){
      Navigator.pushReplacementNamed(context, LoginView.routeName);

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    var provider=Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: Image.asset(provider.isDark()?"assets/images/splash_dark.png":"assets/images/splash.png",fit:BoxFit.cover,height: mediaQuery.height,width: mediaQuery.width,),
    );
  }
}
