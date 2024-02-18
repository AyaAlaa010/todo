import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/config/constants/application_theme_manager.dart';
import 'package:todo/features/layout_view.dart';
import 'package:todo/features/splash/splash_screen.dart';
import 'package:todo/settings_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() {
  runApp(
      ChangeNotifierProvider(
          create: (context)=> SettingsProvider(),
          child:  const MyApplication())
  );}

class MyApplication extends StatelessWidget {
   const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<SettingsProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      darkTheme: ApplicationThmeManager.darkTheme ,
      theme: ApplicationThmeManager.lightTheme,
      themeMode: provider.currentTheme,
      locale: Locale(provider.currentLanguage),
      routes: {
        SplashScreen.routeName:(context)=> const SplashScreen(),
        LayoutView.routeName:(context)=> const LayoutView()
      },
    );
  }
}
