import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/constants/app_colors.dart';
import '../../../settings_providers.dart';
import '../widgets/item_widget.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

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
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(bottom: 55),
          child: Stack(
            alignment: Alignment(0,2.0),
            children:[ Container(
              padding: const EdgeInsetsDirectional.only(top: 60, start: 30),
              height: mediaQuery.height * 0.22,
              width: mediaQuery.width,
              color: AppColors.primaryColor,
              child: Text("To Do List", style:provider.isDark() ? theme.textTheme.titleLarge!.copyWith(color:AppColors.onPrimaryDarkColor) :theme.textTheme.titleLarge),
            ),
            EasyInfiniteDateTimeLine(
              showTimelineHeader: false,
              firstDate:  DateTime(2023),
              focusDate: focusDate,
              lastDate: DateTime(2025),
              timeLineProps: const EasyTimeLineProps(
                  separatorPadding: 20
              ),
              dayProps: EasyDayProps(
                  height: 100,
                  inactiveDayStyle: DayStyle(
                    dayNumStyle: theme.textTheme.bodySmall,
                      dayStrStyle: theme.textTheme.bodySmall,
                      monthStrStyle: theme.textTheme.bodySmall,
                      decoration: BoxDecoration(
                          color: provider.isDark()? AppColors.nav_color
                              :Colors.white,
                          borderRadius:  BorderRadius.circular(10))),
                  todayStyle:DayStyle(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                        borderRadius:  BorderRadius.circular(10)
                    )
                  ) ,

                  activeDayStyle: DayStyle(

                    decoration: BoxDecoration(
                        color: provider.isDark()? AppColors.nav_color:Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black38)),
                    dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.primaryColor,
                    )
                    ,
                    dayStrStyle: theme.textTheme.bodySmall?.copyWith(
                      color: theme.primaryColor,
                    ),
                    monthStrStyle: theme.textTheme.bodySmall?.copyWith(
                      color: theme.primaryColor,
                    ),
                  )),
              onDateChange: (selectedDate) {
                setState(() {
                  focusDate = selectedDate;
                });
              },
            ),


            ]

          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => ItemWidget(),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
