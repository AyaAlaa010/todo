import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/config/constants/app_colors.dart';
import 'package:todo/core/service/loading_sevice.dart';
import 'package:todo/core/widgets/custom_textfield_widget.dart';
import 'package:todo/settings_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_utils.dart';
import 'models/task_model.dart';

class TaskBottomSheet extends StatelessWidget {
  TaskBottomSheet({super.key});
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    var locale = AppLocalizations.of(context)!;
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      width: mediaQuery.width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color:
              provider.isDark() ? AppColors.onPrimaryDarkColor : Colors.white),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              locale.add_new_task,
              textAlign: TextAlign.center,
              style: provider.isDark()
                  ? theme.textTheme.bodyLarge!.copyWith(color: Colors.white)
                  : theme.textTheme.bodyLarge!
                      .copyWith(color: AppColors.darkText),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: titleController,
              textInputType: TextInputType.text,
              suffixIcon: const Icon(null),
              hintText: locale.enter_title,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return locale.must_enter_title;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: descController,
              hintText: locale.enter_description,
              suffixIcon: const Icon(null),
              validator: (value) {
                if (value == null || value.trim().isEmpty)
                  return locale.must_enter_description;
                return null;
              },
              maxLines: 5,
              maxLength: 150,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              locale.select_time,
              style: provider.isDark()
                  ? theme.textTheme.bodyMedium!.copyWith(color: Colors.white)
                  : theme.textTheme.bodyMedium!
                      .copyWith(color: AppColors.darkText),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "15/04/2023",
                  style: provider.isDark()
                      ? theme.textTheme.labelMedium
                      : theme.textTheme.labelMedium!
                          .copyWith(color: AppColors.darkText),
                )),
           const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  TaskModel data = TaskModel(
                      title: titleController.text,
                      description: descController.text,
                      isDone: false,
                      dateTime: DateTime.now());
                  FirebaseUtils(context).addToFirestore(data);
                }
              },
              child: Text(
                locale.add_task,
                style:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
