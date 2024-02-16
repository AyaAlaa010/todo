import 'package:flutter/material.dart';
import 'package:todo/features/settings/pages/settings_view.dart';
import 'package:todo/features/tasks/pages/tasks_view.dart';

class SettingsProvider extends ChangeNotifier{
  ThemeMode currentTheme= ThemeMode.light;

  List<Widget> navigationScreens=[TasksView(),SettingsView()];
  int currentItem=0;

 setCurrentItem(int index){
   if(currentItem==index) return;
   else{
     currentItem=index;
   }
   notifyListeners();
 }

 Widget getCurrentScreen()=> navigationScreens[currentItem];





  changeTheme(ThemeMode themeMode){
    if(themeMode==currentTheme) return;
    else currentTheme=themeMode;
      notifyListeners();
  }



 bool  isDark()=> currentTheme == ThemeMode.dark;




}