import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/constants/app_colors.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    return Column(
     children: [
      Container(
              height: mediaQuery.height*0.2,
              color: AppColors.primaryColor,

            ),

     ],
    );
  }
}
