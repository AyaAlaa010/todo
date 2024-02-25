import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/constants/app_colors.dart';
import '../../../settings_providers.dart';

class SettingsCustomDropDown extends StatelessWidget {
  Function onChange;
  List<String>optionsList;
  String initialValue;

   SettingsCustomDropDown({super.key,required this.optionsList,required this.onChange,required this.initialValue});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context)!;

    return Padding(
      padding: EdgeInsetsDirectional.all(30),
      child: CustomDropdown(
        items: optionsList,
        decoration: CustomDropdownDecoration(
            closedSuffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primaryColor,
            ),
            expandedSuffixIcon: Icon(
              Icons.keyboard_arrow_up_outlined,
              color: AppColors.primaryColor,
            ),
            closedBorder: Border.all(
              color: AppColors.primaryColor,
              width: 2,
            ),
            closedBorderRadius: BorderRadius.zero,
            expandedBorder:
            Border.all(color: AppColors.primaryColor, width: 2),
            expandedBorderRadius: BorderRadius.zero,
            closedFillColor: provider.isDark()
                ? AppColors.onPrimaryDarkColor
                : Colors.white,
            expandedFillColor: provider.isDark()
                ? AppColors.onPrimaryDarkColor
                : Colors.white,
            listItemStyle: provider.isDark()
                ? theme.textTheme.bodyMedium!
                .copyWith(color: AppColors.primaryColor)
                : theme.textTheme.bodyMedium,
            hintStyle: provider.isDark()
                ? theme.textTheme.bodyMedium!
                .copyWith(color: AppColors.primaryColor)
                : theme.textTheme.bodyMedium),
        initialItem: initialValue,
        onChanged: (value) {
         onChange(value);

        },
      ),
    );
  }
}
