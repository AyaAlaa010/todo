import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/constants/app_colors.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    var theme=Theme.of(context);
    return Container(
      width: mediaQuery.width,
      height: 115,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 10),
      margin:const  EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white
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
              Text("Play basketball",style: theme.textTheme.bodyLarge,),
              const SizedBox(height: 6,),
              Row(
                children: [
                  const Icon(Icons.alarm,size: 20,),
                  const SizedBox(width: 5,),
                  Text("10:30 AM",style: theme.textTheme.bodySmall!.copyWith(color: AppColors.darkText),)
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

            child:const  Icon(Icons.check_rounded,color: Colors.white,size: 38,),
          )


        ],
      ),
    );
  }
}
