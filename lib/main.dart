import 'package:flutter/material.dart';
import 'package:todo/features/layout_view.dart';
import 'package:todo/features/splash/splash_screen.dart';

void main() {
  runApp(const MyApplication());
}
class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName:(context)=> SplashScreen(),
        LayoutView.routeName:(context)=> LayoutView()
      },
    );
  }
}
