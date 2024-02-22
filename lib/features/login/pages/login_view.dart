import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo/config/constants/app_colors.dart';
import 'package:todo/firebase_utils.dart';

import '../../../settings_providers.dart';

class LoginView extends StatelessWidget {
  static const routeName="loginView";
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    var provider=Provider.of<SettingsProvider>(context);
    return  Scaffold(
      backgroundColor: provider.isDark() ? AppColors.onPrimaryDarkColor:AppColors.onPrimaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(onPressed: (){
        //    FirebaseUtils().createAccount("aya@gmail.com", "Aa12345");
            FirebaseUtils().createAccount("aya@gmail.com", "Aa12345").then((value) {if(value) {
              BotToast.showText(text: "Successfully Login");
              EasyLoading.dismiss();
            } });

          }, child: Text("Sign up ")
          )



        ],



      )
    );
  }
}
