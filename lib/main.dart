import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/config/constants/application_theme_manager.dart';
import 'package:todo/features/layout_view.dart';
import 'package:todo/features/splash/splash_screen.dart';
import 'package:todo/settings_providers.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (context)=>SettingsProvider(),
          child:  MyApplication())
  );}

class MyApplication extends StatelessWidget {
   MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      darkTheme: ApplicationThmeManager.darkTheme ,
      theme: ApplicationThmeManager.lightTheme,
      themeMode: provider.currentTheme,
      routes: {
        SplashScreen.routeName:(context)=> SplashScreen(),
        LayoutView.routeName:(context)=> LayoutView()
      },
    );
  }
}
