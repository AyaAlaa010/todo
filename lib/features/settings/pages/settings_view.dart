import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/settings/widgets/custom_drop_down.dart';

import '../../../config/constants/app_colors.dart';
import '../../../settings_providers.dart';

class SettingsView extends StatelessWidget {
  List<String> languagesList = ["English", "عربي"];
  List<String> themesList = ["Light", "Dark"];
  late var  provider;

  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
     provider = Provider.of<SettingsProvider>(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(top: 50, start: 30),
          height: mediaQuery.height * 0.2,
          width: mediaQuery.width,
          color: AppColors.primaryColor,
          child: Text(
            "Settings",
            style: provider.isDark()
                ? theme.textTheme.titleLarge!
                    .copyWith(color: AppColors.darkText)
                : theme.textTheme.titleLarge!,
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 30, top: 30),
          child: Text("Language",
              style: provider.isDark()
                  ? theme.textTheme.bodyMedium!.copyWith(color: Colors.white)
                  : theme.textTheme.bodyMedium!.copyWith(color: AppColors.darkText)),
        ),
        SettingsCustomDropDown(optionsList: languagesList, onChange: onChangeLanguage),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 30),
          child: Text("Mode",
              style: provider.isDark()
                  ? theme.textTheme.bodyMedium!.copyWith(color: Colors.white)
                  : theme.textTheme.bodyMedium!
                      .copyWith(color: AppColors.darkText)),
        ),
       SettingsCustomDropDown(optionsList: themesList, onChange: onChangeTheme),
        const Spacer()
      ],
    );
  }

  void onChangeTheme(String value){
    if(value=="Light"){
      provider.changeTheme(ThemeMode.light);
    }
    else if(value== "Dark"){
      provider.changeTheme(ThemeMode.dark);
    }
  }

  void onChangeLanguage(String value){
    if(value=="English"){

    }
    else if(value== "عربي"){

    }
  }

}
