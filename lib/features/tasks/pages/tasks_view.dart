import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/constants/app_colors.dart';
import '../../../settings_providers.dart';
import '../widgets/item_widget.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context)!;
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    DateTime focusDate = DateTime.now();
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(bottom: 40),
          child: Stack(
            alignment: Alignment(0,2.0),
            children:[ Container(
              padding: const EdgeInsetsDirectional.only(top: 60, start: 30),
              height: mediaQuery.height * 0.2,
              width: mediaQuery.width,
              color: AppColors.primaryColor,
              child: Text("To Do List", style: theme.textTheme.titleLarge),
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
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:  BorderRadius.circular(10))),
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primaryColor)),
                    dayNumStyle: theme.textTheme.bodyMedium,
                    dayStrStyle: theme.textTheme.bodySmall,
                    monthStrStyle: theme.textTheme.bodySmall,
                  )),
              onDateChange: (selectedDate) {
                setState(() {
                  focusDate = selectedDate;
                });
              },
            ),]

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
