import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/constants/app_colors.dart';
import '../../../settings_providers.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    var theme=Theme.of(context);
    var provider=Provider.of<SettingsProvider>(context)!;
    return Container(
      width: mediaQuery.width,
      height: 115,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 10),
      margin:const  EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:provider.isDark()? AppColors.nav_color: Colors.white
      ),
      child: Row(
        children: [
          Container(
            height: 90,width: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:AppColors.primaryColor
            ),
          ),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Play basketball",style:provider.isDark()? theme.textTheme.bodyLarge!.copyWith(color:AppColors.primaryColor) : theme.textTheme.bodyLarge,),
              const SizedBox(height: 6,),
              Row(
                children: [
                   Icon(Icons.alarm,size: 20,color:provider.isDark()? Colors.white : AppColors.darkText),
                  const SizedBox(width: 5,),
                  Text("10:30 AM",style:provider.isDark()?theme.textTheme.bodySmall! : theme.textTheme.bodySmall!.copyWith(color: AppColors.darkText),)
                ],
              ),

            ],
          ),
          Spacer(),
          Container(
            padding:const EdgeInsetsDirectional.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)
            ),

            child:const  Icon(Icons.check_rounded,color: Colors.white,size: 35,),
          )


        ],
      ),
    );
  }
}
