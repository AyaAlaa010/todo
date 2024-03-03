import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/config/constants/app_colors.dart';
import '../../../models/task_model.dart';
import '../../../settings_providers.dart';
import '../widgets/task_item_widget.dart';

class TasksView extends StatefulWidget {
   TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  DateTime focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context)!;
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context)!;

    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(bottom: 45),
          child: Stack(alignment: Alignment(0, 2.0), children: [
            Container(
              padding: const EdgeInsetsDirectional.only(top: 50, start: 30),
              height: mediaQuery.height * 0.22,
              width: mediaQuery.width,
              color: AppColors.primaryColor,
              child: Text(locale.todo_list,
                  style: provider.isDark()
                      ? theme.textTheme.titleLarge!
                          .copyWith(color: AppColors.onPrimaryDarkColor)
                      : theme.textTheme.titleLarge),
            ),
            EasyInfiniteDateTimeLine(
              showTimelineHeader: false,
              firstDate: DateTime(2023),
              focusDate: focusDate,
              lastDate: DateTime(2025),
              timeLineProps: const EasyTimeLineProps(separatorPadding: 20),
              dayProps: EasyDayProps(
                  height: 100,
                  inactiveDayStyle: DayStyle(
                      dayNumStyle: theme.textTheme.bodyMedium!.copyWith(
                          color: provider.isDark()
                              ? Colors.white
                              : AppColors.darkText),
                      dayStrStyle: theme.textTheme.bodyMedium!.copyWith(
                          color: provider.isDark()
                              ? Colors.white
                              : AppColors.darkText),
                      monthStrStyle: theme.textTheme.bodyMedium!.copyWith(
                          color: provider.isDark()
                              ? Colors.white
                              : AppColors.darkText),
                      decoration: BoxDecoration(
                          color: provider.isDark()
                              ? AppColors.nav_color
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10))),
                  todayStyle: DayStyle(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10))),
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: provider.isDark()
                            ? AppColors.nav_color
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black38)),
                    dayNumStyle: provider.isDark()
                        ? theme.textTheme.bodyMedium!
                            .copyWith(color: AppColors.primaryColor)
                        : theme.textTheme.bodyMedium,
                    dayStrStyle: provider.isDark()
                        ? theme.textTheme.bodyMedium!
                            .copyWith(color: AppColors.primaryColor)
                        : theme.textTheme.bodyMedium,
                    monthStrStyle: provider.isDark()
                        ? theme.textTheme.bodyMedium!
                            .copyWith(color: AppColors.primaryColor)
                        : theme.textTheme.bodyMedium,
                  )),
              onDateChange: (selectedDate) {
                setState(() {
                  focusDate = selectedDate;
                  provider.selectedTime = selectedDate;
                });
              },
            ),
          ]),
        ),
        StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseUtils
                .getStreamDataFromFirestore(provider.selectedTime),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(
                      locale.unkown_error,
                      style: provider.isDark()
                          ? theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white)
                          : theme.textTheme.bodyMedium
                              ?.copyWith(color: AppColors.darkText),
                    ),
                    const Center(child: Icon(Icons.refresh))
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var taskList =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) =>
                        TaskItemWidget(taskModel: taskList[index]),
                    itemCount: taskList.length,
                  ),
                );
              }
            })
        // FutureBuilder<List<TaskModel>>(future: FirebaseUtils(context).getDataFromFirestore(provider.selectedTime), builder: (context,snapshot){
        //   if(snapshot.hasError){
        //     return Column(
        //       children: [
        //         Text(locale.unkown_error,style: provider.isDark()? theme.textTheme.bodyMedium?.copyWith(color: Colors.white) :theme.textTheme.bodyMedium?.copyWith(color: AppColors.darkText),)
        //     , const Center(child: Icon(Icons.refresh))
        //       ],
        //     );
        //   }
        //   else if(snapshot.connectionState==ConnectionState.waiting){
        //     return const Center(child: CircularProgressIndicator());
        //   }
        //   else{
        //     var taskList=snapshot.data ?? [];
        //     return    Expanded(
        //       child: ListView.builder(
        //         padding: EdgeInsets.zero,
        //         itemBuilder: (context, index) => TaskWidget(taskModel:taskList[index]),
        //         itemCount: taskList.length,
        //       ),
        //     );
        //   }
        //
        // })

        ,
      ],
    );
  }
}
