import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/core/config/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SnackerService{
  BuildContext context;
 late  var theme,locale;
  SnackerService(this.context){
     theme=Theme.of(context);
     locale= AppLocalizations.of(context)!;
  }


  showSuccessMsg(String msg){
    BotToast.showCustomNotification(toastBuilder: (cancelFunc) {
      return Material(
        child:Container(
          width: double.infinity,
          height: 50,
          child: Row(
            children: [
              Container(height: 50,width:15,color: Colors.lightBlueAccent,),
              Lottie.asset("assets/images/login_success.json",width: 80,height: 50),
              Expanded(flex:3,child: Text(msg,style:theme.textTheme.labelMedium!.copyWith(color: AppColors.primaryColor))),
              Container(height: 50,width:2,color: Colors.lightBlueAccent,),
              Expanded(flex:1,child: InkWell(onTap:(){
                BotToast.cleanAll();
              },


              child: Text(locale.close,style:theme.textTheme.labelMedium!.copyWith(color: AppColors.primaryColor),textAlign: TextAlign.center,))),

            ],

          ),
        )


      );

    },duration: const Duration(seconds: 10),dismissDirections: [DismissDirection.endToStart]);

  }
  showErrorMsg(String msg){

    BotToast.showCustomNotification(toastBuilder: (cancelFunc) {
      return Material(
          child:Container(
            width: double.infinity,
            height: 50,
            child: Row(
              children: [
                Container(height: 50,width:15,color: Colors.red,),
                Lottie.asset("assets/images/login_error.json",width: 80,height: 50),
                Expanded(flex:3,child: Text(msg,style:theme.textTheme.labelMedium!.copyWith(color: Colors.red))),
                Container(height: 50,width:2,color: Colors.red,),
                Expanded(flex:1,child: InkWell(onTap:(){
                  BotToast.cleanAll();
                }, child: Text(locale.close,style:theme.textTheme.labelMedium!.copyWith(color: Colors.red),textAlign: TextAlign.center,))),

              ],

            ),
          )
      );

    },duration: const Duration(seconds: 10),dismissDirections: [DismissDirection.endToStart]);
  }


}