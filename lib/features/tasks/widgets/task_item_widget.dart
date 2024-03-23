import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/edite/pages/edite_view.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/config/constants/app_colors.dart';
import '../../../core/service/snakers_service.dart';
import '../../../settings_providers.dart';

class TaskItemWidget extends StatefulWidget {
  TaskModel taskModel;

  TaskItemWidget({required this.taskModel, super.key});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  late var locale;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
     locale = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context)!;
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, EditeView.routeName,arguments:widget.taskModel );
      },
      child: Container(
        margin:
            const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: AppColors.RED),
        child: Slidable(
         key: const ValueKey(0),

          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            extentRatio: 0.265,
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),
            // A pane can dismiss the Slidable.
           // dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                onPressed: (context) {
                 delete(context);
                },
                backgroundColor: AppColors.RED,
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular(15),
                icon: Icons.delete,
                label: locale.delete,

              ),
            ],
          ),

          child: Container(
            width: mediaQuery.width,
            height: 115,
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: provider.isDark() ? AppColors.nav_color : Colors.white),
            child: Row(
              children: [
                Container(
                  height: 90,
                  width: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.taskModel.isDone
                          ? AppColors.GREEN
                          : AppColors.primaryColor),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          widget.taskModel.title,
                          style: widget.taskModel.isDone
                              ? theme.textTheme.bodyLarge!
                                  .copyWith(color: AppColors.GREEN)
                              : provider.isDark()
                                  ? theme.textTheme.bodyLarge!
                                      .copyWith(color: AppColors.primaryColor)
                                  : theme.textTheme.bodyLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.taskModel.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: provider.isDark()
                              ? theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.white)
                              : theme.textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.darkText),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.alarm,
                                size: 20,
                                color: provider.isDark()
                                    ? Colors.white
                                    : AppColors.darkText),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              DateFormat.yMMMMd().format(widget.taskModel.dateTime),
                              style: provider.isDark()
                                  ? theme.textTheme.bodySmall!
                                  : theme.textTheme.bodySmall!
                                      .copyWith(color: AppColors.darkText),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if (widget.taskModel.isDone)
                  InkWell(
                    onTap: (){
                      setState(() {
                        widget.taskModel.isDone=!widget.taskModel.isDone;
                        update(context);
                      });

                    },
                    child: Text(
                      locale.done,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: AppColors.GREEN),
                    ),
                  )
                else
                  InkWell(
                    onTap: (){
                      setState(() {
                        widget.taskModel.isDone=!widget.taskModel.isDone;
                        update(context);
                      });
                    },
                    child: Container(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void update( BuildContext context){
    TaskModel data=TaskModel(id:widget.taskModel.id,title: widget.taskModel.title, description: widget.taskModel.description, isDone:widget.taskModel.isDone, dateTime:  widget.taskModel.dateTime);
    EasyLoading.show();
    FirebaseUtils.updateTask(data).then((value) {
      EasyLoading.dismiss();
      SnackerService.showSuccessMsg(locale.task_success_update,context);
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      SnackerService.showErrorMsg(locale.unkown_error,context);
    });

  }

  void delete(BuildContext context){
    EasyLoading.show();
    FirebaseUtils.deleteTask(widget.taskModel).then((value) {
      EasyLoading.dismiss();
      BotToast.showText(text: locale.task_success_deleted);
      //SnackerService.showSuccessMsg(locale.task_success_deleted,context);
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      BotToast.showText(text: locale.unkown_error);
      //SnackerService.showErrorMsg(locale.unkown_error,context);
    });

  }
}


