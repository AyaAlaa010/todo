import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/layout_view.dart';
import 'package:todo/features/login/pages/login_view.dart';
import 'package:todo/features/register/pages/register_view.dart';
import 'package:todo/features/splash/splash_screen.dart';
import 'package:todo/settings_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/application_theme_manager.dart';
import 'core/service/loading_sevice.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LoadingService().configLoading();

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
      initialRoute: LoginView.routeName,
      darkTheme: ApplicationThmeManager.darkTheme ,
      theme: ApplicationThmeManager.lightTheme,
      themeMode: provider.currentTheme,
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: EasyLoading.init(builder:BotToastInit()),
      locale: Locale(provider.currentLanguage),
      routes: {
        SplashScreen.routeName:(context)=> const SplashScreen(),
        LayoutView.routeName:(context)=>  LayoutView(),
        LoginView.routeName:(context)=> LoginView(),
        RegisterView.routeName:(context)=>  RegisterView()
      },
    );
  }
}
