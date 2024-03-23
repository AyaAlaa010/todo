import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/config/common.dart';
import '../../../core/config/constants/app_colors.dart';
import '../../../core/service/snakers_service.dart';
import '../../../core/widgets/custom_textfield_widget.dart';
import '../../../firebase_utils.dart';
import '../../../models/task_model.dart';
import '../../../settings_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditeView extends StatefulWidget {

  static String routeName="EditeView";

  const  EditeView({super.key});

  @override
  State<EditeView> createState() => _EditeViewState();
}

class _EditeViewState extends State<EditeView> {

  @override
  Widget build(BuildContext context) {
    final taskModel = ModalRoute.of(context)!.settings.arguments as TaskModel;
    var mediaQuery=MediaQuery.of(context).size;
    var provider = Provider.of<SettingsProvider>(context)!;
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: mediaQuery.height * 0.08, // Set this height
        backgroundColor: AppColors.primaryColor,
        title: Text(locale.todo_list, style:provider.isDark()
            ? theme.textTheme.titleLarge!
            .copyWith(color: AppColors.onPrimaryDarkColor)
            : theme.textTheme.titleLarge),iconTheme:const  IconThemeData(
          color: Colors.white
        ),),
      body:Stack(
        children: [
      Container(
      height: mediaQuery.height * 0.22,
          width: mediaQuery.width,
          color: AppColors.primaryColor,),
          Container(
            padding: const EdgeInsets.all(20),
            margin:const  EdgeInsets.only(top: 20, left: 25, right:25 , bottom: 80),
            width: mediaQuery.width,
            height: mediaQuery.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Expanded(
                       flex: 2,
                       child: Text(
                         locale.edit_task,
                         textAlign: TextAlign.center,
                         style: provider.isDark()
                             ? theme.textTheme.bodyLarge!.copyWith(color: Colors.white)
                             : theme.textTheme.bodyLarge!
                             .copyWith(color: AppColors.darkText),
                       ),
                     ),
                     const SizedBox(height: 10),
                     Expanded(flex: 1,
                       child: CustomTextField(
                          initialValue: taskModel.title,
                         onChanged: (value){
                           taskModel.title=value!;
                           setState(() {

                           });
                         },
                         textInputType: TextInputType.text,
                         suffixIcon: const Icon(null),
                         hintText: locale.enter_title,
                       ),

                     ),

                     Expanded(
                       flex: 3,
                       child: CustomTextField(
                         onChanged: (value){
                           taskModel.description=value!;
                           setState(() {
                           });
                         },
                         initialValue: taskModel.description,
                         hintText: locale.enter_description,
                         suffixIcon: const Icon(null),
                         maxLines: 3,
                         maxLength: 150,
                       ),
                     ),

                     Expanded(
                       flex: 2,
                       child: Text(
                         locale.select_time,
                         style: provider.isDark()
                             ? theme.textTheme.bodyMedium!.copyWith(color: Colors.white)
                             : theme.textTheme.bodyMedium!
                             .copyWith(color: AppColors.darkText),
                       ),
                     ),
                     Expanded(
                       flex: 2,
                       child: TextButton(
                           onPressed: () {
                             provider.selectTime(context);
                           },
                           child: Text(
                             DateFormat.yMMMMd().format(provider.selectedTime),
                             style: provider.isDark()
                                 ? theme.textTheme.labelMedium
                                 : theme.textTheme.labelMedium!
                                 .copyWith(color: AppColors.darkText),
                           )),
                     ),
                     const SizedBox(height: 20,),
                     Expanded(flex: 1,
                       child: ElevatedButton(
                         onPressed: () {
                             EasyLoading.show();
                             taskModel.dateTime= Common.extractDate(provider.selectedTime);
                             FirebaseUtils.updateTask(taskModel).then((value) {
                               EasyLoading.dismiss();
                               SnackerService.showSuccessMsg(locale.task_success_created,context);
                               Navigator.pop(context);
                             });

                         },
                         style: ElevatedButton.styleFrom(
                             backgroundColor: AppColors.primaryColor),
                         child:  Text(
                           locale.save_changes,
                           style:
                           theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                         ),
                       ),
                     )
                   ],
                 ),

          ),
      
        ],
      
        ),
      );


  }
}
